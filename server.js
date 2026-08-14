'use strict';

require('dotenv').config();
const path = require('path');
const crypto = require('crypto');
const { spawn } = require('child_process');
const express = require('express');
const helmet = require('helmet');
const session = require('express-session');
const MySQLSessionStore = require('express-mysql-session')(session);
const rateLimit = require('express-rate-limit');
const bcrypt = require('bcryptjs');
const mysql = require('mysql2/promise');

const app = express();
const PORT = Number(process.env.PORT || 3000);
const isProduction = process.env.NODE_ENV === 'production';

app.set('trust proxy', 1);
app.use(helmet({ contentSecurityPolicy: false, crossOriginResourcePolicy: { policy: 'cross-origin' } }));
app.use(express.json({ limit: '32kb' }));
app.use(express.urlencoded({ extended: false }));
const canonicalUrl=process.env.APP_URL;
if(canonicalUrl&&process.env.ENFORCE_CANONICAL_URL==='true'){
  app.use((req,res,next)=>{
    if(req.method!=='GET'||!String(req.headers.accept||'').includes('text/html'))return next();
    try{const canonical=new URL(canonicalUrl);if(req.headers.host!==canonical.host)return res.redirect(302,new URL(req.originalUrl,canonical).toString());}catch{}
    next();
  });
}
const sessionStore = process.env.DB_HOST ? new MySQLSessionStore({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'hope',
  connectionLimit: 4,
  clearExpired: true,
  checkExpirationInterval: 15 * 60 * 1000,
  expiration: 7 * 24 * 60 * 60 * 1000,
  createDatabaseTable: false,
  schema: { tableName:'web_sessions', columnNames:{ session_id:'session_id', expires:'expires', data:'data' } }
}) : undefined;
app.use(session({
  name: 'hope.sid',
  secret: process.env.SESSION_SECRET || 'development-only-change-this-secret',
  store: sessionStore,
  resave: false,
  saveUninitialized: false,
  rolling: true,
  proxy: true,
  cookie: { httpOnly: true, sameSite: 'lax', secure: 'auto', maxAge: 1000 * 60 * 60 * 24 * 7 }
}));

const authLimiter = rateLimit({ windowMs: 15 * 60 * 1000, limit: 30, standardHeaders: 'draft-8', legacyHeaders: false });
app.use('/api/auth', authLimiter);

let pool;
function database() {
  if (!pool && process.env.DB_HOST) {
    pool = mysql.createPool({
      host: process.env.DB_HOST,
      port: Number(process.env.DB_PORT || 3306),
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME || 'hope',
      waitForConnections: true,
      connectionLimit: Number(process.env.DB_POOL_SIZE || 8),
      queueLimit: 0,
      charset: 'utf8mb4'
    });
  }
  return pool;
}

const vehicleNames = { 400:'Landstalker', 411:'Infernus', 415:'Cheetah', 421:'Washington', 426:'Premier', 429:'Banshee', 445:'Admiral', 451:'Turismo', 468:'Sanchez', 475:'Sabre', 496:'Blista Compact', 507:'Elegant', 515:'Roadtrain', 522:'NRG-500', 541:'Bullet', 560:'Sultan', 562:'Elegy', 565:'Flash', 579:'Huntley' };
const jobNames = ['Unemployed','Trucker','Bus Driver','Mechanic','Farmer','Fisherman','Miner','Lumberjack','Taxi Driver','Courier','Milkman'];
const factionNames = ['Civilian','San Andreas Police','San Andreas Government','San Andreas Medical','San Andreas News','San Andreas Judiciary'];

function publicStatsFallback() {
  return { players: 0, ucps: 0, vehicles: 0, properties: 0, businesses: 0, families: 0, workshops: 0, online: 0, database: 'offline', serverAddress: process.env.SAMP_SERVER_ADDRESS || '', discordInvite: process.env.DISCORD_INVITE_URL || '' };
}
function clientIp(req) { return String(req.ip || '').replace('::ffff:', '').slice(0, 17) || '127.0.0.1'; }
function cleanText(value, max = 32) { return String(value || '').trim().slice(0, max); }
function requireAuth(req, res, next) { return req.session.user ? next() : res.status(401).json({ error: 'Silakan masuk ke UCP terlebih dahulu.' }); }
function asyncRoute(fn) { return (req, res, next) => Promise.resolve(fn(req, res, next)).catch(next); }
async function effectiveAdminLevel(userId) {
  if (!database()) return 0;
  const [rows] = await database().execute(`SELECT GREATEST(COALESCE(u.admin,0), COALESCE(MAX(p.admin),0)) level
    FROM ucp u LEFT JOIN players p ON p.ucp = u.username WHERE u.id = ? GROUP BY u.id, u.admin`, [userId]);
  return Number(rows[0]?.level || 0);
}
async function requireAdmin(req, res, next) {
  if (!req.session.user) return res.status(401).json({ error: 'Silakan masuk terlebih dahulu.' });
  try {
    const level = await effectiveAdminLevel(req.session.user.id);
    if (level < 1) return res.status(403).json({ error: 'Akses khusus administrator.' });
    req.adminLevel = level;
    next();
  } catch (error) { next(error); }
}
async function requireForum(req, res, next) {
  if (!database()) return res.status(503).json({ error:'Database sedang offline.' });
  try {
    await database().query('SELECT 1 FROM web_forum_categories LIMIT 1');
    next();
  } catch (error) {
    if (error.code === 'ER_NO_SUCH_TABLE') return res.status(503).json({ error:'Forum belum dimigrasikan. Jalankan scripts/termux-migrate.sh.' });
    next(error);
  }
}

app.get('/api/health', asyncRoute(async (req, res) => {
  let db = 'not-configured';
  try { if (database()) { await database().query('SELECT 1'); db = 'connected'; } } catch { db = 'unavailable'; }
  res.json({ ok: true, database: db, service: 'Hope Pride Roleplay' });
}));

app.get('/api/public', asyncRoute(async (req, res) => {
  if (!database()) return res.json(publicStatsFallback());
  try {
    const [[players], [ucps], [vehicles], [houses], [businesses], [families], [workshops]] = await Promise.all([
      database().query('SELECT COUNT(*) total FROM players'), database().query('SELECT COUNT(*) total FROM ucp'),
      database().query('SELECT COUNT(*) total FROM vehicle'), database().query('SELECT COUNT(*) total FROM houses'),
      database().query('SELECT COUNT(*) total FROM bisnis'), database().query('SELECT COUNT(*) total FROM familys'),
      database().query('SELECT COUNT(*) total FROM workshop')
    ]);
    res.json({ players: players[0].total, ucps: ucps[0].total, vehicles: vehicles[0].total, properties: houses[0].total, businesses: businesses[0].total, families:families[0].total, workshops:workshops[0].total, online: Number(process.env.SAMP_ONLINE_PLAYERS || 0), database: 'live', serverAddress: process.env.SAMP_SERVER_ADDRESS || '', discordInvite: process.env.DISCORD_INVITE_URL || '' });
  } catch { res.json(publicStatsFallback()); }
}));

app.get('/api/city/businesses', asyncRoute(async (req, res) => {
  if (!database()) return res.status(503).json({ error:'Database sedang offline.', businesses:[] });
  const type = Number(req.query.type || 0);
  const q = cleanText(req.query.q, 40);
  const clauses = [], params = [];
  if ([1,2,3,4].includes(type)) { clauses.push('type = ?'); params.push(type); }
  if (q) { clauses.push('(name LIKE ? OR owner LIKE ?)'); params.push(`%${q}%`, `%${q}%`); }
  const where = clauses.length ? `WHERE ${clauses.join(' AND ')}` : '';
  const [rows] = await database().execute(`SELECT ID id, name, owner, type, price, locked, prod, restock FROM bisnis ${where} ORDER BY locked ASC, name ASC LIMIT 60`, params);
  res.json({ businesses:rows, total:rows.length });
}));

app.get('/api/session', (req, res) => res.json({ authenticated: Boolean(req.session.user), user: req.session.user || null }));

app.post('/api/auth/login', asyncRoute(async (req, res) => {
  const username = cleanText(req.body.username, 25);
  const password = String(req.body.password || '');
  if (!username || !password) return res.status(400).json({ error: 'Username dan password wajib diisi.' });
  if (!database()) return res.status(503).json({ error: 'Database belum dikonfigurasi pada server.' });
  const [rows] = await database().execute('SELECT id, username, password, admin, verifystatus, discordid, registerdate FROM ucp WHERE username = ? LIMIT 1', [username]);
  const user = rows[0];
  if (!user || !user.password || !(await bcrypt.compare(password, user.password))) return res.status(401).json({ error: 'Username atau password tidak cocok.' });
  if (!Number(user.verifystatus)) return res.status(403).json({ error: 'Akun belum diverifikasi melalui Discord.' });
  req.session.regenerate(err => {
    if (err) return res.status(500).json({ error: 'Gagal membuat sesi.' });
    req.session.user = { id: user.id, username: user.username, admin: Number(user.admin || 0) };
    res.json({ ok: true, user: req.session.user });
  });
}));

app.post('/api/auth/register', asyncRoute(async (req, res) => {
  const username = cleanText(req.body.username, 25);
  const discordId = cleanText(req.body.discordId, 32);
  const password = String(req.body.password || '');
  if (!/^[A-Za-z0-9_]{3,25}$/.test(username)) return res.status(400).json({ error: 'Username harus 3–25 karakter (huruf, angka, underscore).' });
  if (!/^\d{17,20}$/.test(discordId)) return res.status(400).json({ error: 'Discord ID tidak valid.' });
  if (password.length < 8 || password.length > 72) return res.status(400).json({ error: 'Password harus 8–72 karakter.' });
  if (!database()) return res.status(503).json({ error: 'Database belum dikonfigurasi pada server.' });
  const [existing] = await database().execute('SELECT id FROM ucp WHERE username = ? OR discordid = ? LIMIT 1', [username, discordId]);
  if (existing.length) return res.status(409).json({ error: 'Username atau Discord ID sudah terdaftar.' });
  const hash = await bcrypt.hash(password, 12);
  const verifyCode = `HP-${crypto.randomInt(100000, 999999)}`;
  const registered = new Date().toISOString().slice(0, 19).replace('T', ' ');
  await database().execute('INSERT INTO ucp (username, password, ip, admin, verifystatus, verifycode, discordid, registerdate) VALUES (?, ?, ?, 0, 0, ?, ?, ?)', [username, hash, clientIp(req), verifyCode, discordId, registered]);
  res.status(201).json({ ok: true, verifyCode, gamePin: verifyCode, message: 'UCP berhasil dibuat. Gunakan PIN ini untuk aktivasi di dalam game dan verifikasi Discord.' });
}));

app.post('/api/auth/logout', (req, res) => req.session.destroy(() => res.json({ ok: true })));

app.get('/api/me', requireAuth, asyncRoute(async (req, res) => {
  const db = database();
  const [[ucpRows], [characters]] = await Promise.all([
    db.execute('SELECT username, admin, verifystatus, verifycode, discordid, registerdate FROM ucp WHERE id = ? LIMIT 1', [req.session.user.id]),
    db.execute(`SELECT reg_id, username, level, admin, helper, hours, minutes, money, bmoney, phone, job, faction, factionrank, vip, skin, health, armour, hunger, energy, last_login FROM players WHERE ucp = ? ORDER BY reg_id`, [req.session.user.username])
  ]);
  const names = characters.map(c => c.username);
  const ids = characters.map(c => c.reg_id);
  let vehicles = [], properties = [], businesses = [], inventory = [], salaries = [], skills = [], fish = [];
  if (names.length) {
    const marks = names.map(() => '?').join(',');
    [properties] = await db.query(`SELECT ID id, owner, address, price, locked FROM houses WHERE owner IN (${marks}) ORDER BY ID DESC`, names);
    [businesses] = await db.query(`SELECT ID id, owner, name, type, price, locked, money, prod, restock FROM bisnis WHERE owner IN (${marks}) ORDER BY ID DESC`, names);
  }
  if (ids.length) {
    const marks = ids.map(() => '?').join(',');
    [vehicles] = await db.query(`SELECT id, owner, model, plate, health, fuel, locked FROM vehicle WHERE owner IN (${marks}) ORDER BY id DESC`, ids);
    [inventory] = await db.query(`SELECT item, SUM(quantity) quantity FROM inventory WHERE ownerid IN (${marks}) GROUP BY item ORDER BY quantity DESC LIMIT 24`, ids);
    [salaries] = await db.query(`SELECT info, money, date FROM salary WHERE owner IN (${marks}) ORDER BY id DESC LIMIT 10`, ids);
    [skills] = await db.query(`SELECT owner, name, level, exp FROM player_skill WHERE owner IN (${marks}) ORDER BY owner, level DESC`, ids);
    [fish] = await db.query(`SELECT owner, name, weight FROM player_fish WHERE owner IN (${marks}) ORDER BY weight DESC LIMIT 20`, ids);
  }
  const adminLevel = Math.max(Number(ucpRows[0].admin || 0), ...characters.map(c => Number(c.admin || 0)), 0);
  res.json({
    ucp: { username: ucpRows[0].username, verified: Boolean(ucpRows[0].verifystatus), admin: adminLevel, isAdmin: adminLevel > 0, gamePin: ucpRows[0].verifycode, discordId: ucpRows[0].discordid, registered: ucpRows[0].registerdate },
    characters: characters.map(c => ({ id:c.reg_id, name:c.username, level:c.level, hours:c.hours, minutes:c.minutes, money:c.money, bank:c.bmoney, phone:c.phone, job:jobNames[c.job] || `Job ${c.job}`, faction:factionNames[c.faction] || `Faction ${c.faction}`, factionRank:c.factionrank, vip:c.vip, skin:c.skin, health:c.health, armour:c.armour, hunger:c.hunger, energy:c.energy, lastLogin:c.last_login, vehicles:vehicles.filter(v=>Number(v.owner)===Number(c.reg_id)).length, houses:properties.filter(h=>h.owner===c.username).length })),
    vehicles: vehicles.map(v => ({ ...v, owner: characters.find(c => Number(c.reg_id) === Number(v.owner))?.username || `Character #${v.owner}`, name: vehicleNames[v.model] || `Vehicle ${v.model}`, locked: Boolean(v.locked) })),
    properties: properties.map(h => ({ ...h, locked: Boolean(h.locked) })),
    businesses: businesses.map(b => ({ ...b, locked:Boolean(b.locked), typeName:['','Warung & Restoran','Toko Umum','Toko Pakaian','Usaha Khusus'][b.type] || `Bisnis ${b.type}` })),
    inventory, salaries, skills, fish
  });
}));

app.patch('/api/me/password', requireAuth, asyncRoute(async (req, res) => {
  const currentPassword = String(req.body.currentPassword || '');
  const newPassword = String(req.body.newPassword || '');
  if (newPassword.length < 8 || newPassword.length > 72) return res.status(400).json({ error:'Password baru harus 8–72 karakter.' });
  const [rows] = await database().execute('SELECT password FROM ucp WHERE id = ? LIMIT 1', [req.session.user.id]);
  if (!rows[0]?.password || !(await bcrypt.compare(currentPassword, rows[0].password))) return res.status(401).json({ error:'Password saat ini tidak cocok.' });
  const hash = await bcrypt.hash(newPassword, 12);
  await database().execute('UPDATE ucp SET password = ? WHERE id = ?', [hash, req.session.user.id]);
  res.json({ ok:true, message:'Password UCP berhasil diperbarui.' });
}));

app.patch('/api/me/discord', requireAuth, asyncRoute(async (req, res) => {
  const currentPassword = String(req.body.currentPassword || '');
  const discordId = cleanText(req.body.discordId, 32);
  if (!/^\d{17,20}$/.test(discordId)) return res.status(400).json({ error:'Discord User ID tidak valid.' });
  const [rows] = await database().execute('SELECT password, discordid FROM ucp WHERE id = ? LIMIT 1', [req.session.user.id]);
  if (!rows[0]?.password || !(await bcrypt.compare(currentPassword, rows[0].password))) return res.status(401).json({ error:'Password UCP tidak cocok.' });
  if (String(rows[0].discordid) === discordId) return res.status(400).json({ error:'Discord ID baru sama dengan ID sekarang.' });
  const [used] = await database().execute('SELECT id FROM ucp WHERE discordid = ? AND id != ? LIMIT 1', [discordId, req.session.user.id]);
  if (used.length) return res.status(409).json({ error:'Discord ID sudah digunakan UCP lain.' });
  const verifyCode = `HP-${crypto.randomInt(100000, 999999)}`;
  await database().execute('UPDATE ucp SET discordid = ?, verifystatus = 0, verifycode = ? WHERE id = ?', [discordId, verifyCode, req.session.user.id]);
  res.json({ ok:true, verifyCode, message:'Discord ID diperbarui. Verifikasi ulang melalui bot Discord.' });
}));

app.get('/api/forum/categories', requireForum, asyncRoute(async (req, res) => {
  const [rows] = await database().query(`SELECT c.id,c.slug,c.name,c.description,c.icon,c.admin_only,
    COUNT(DISTINCT t.id) topics, COUNT(p.id) posts, MAX(t.updated_at) latest_at
    FROM web_forum_categories c LEFT JOIN web_forum_topics t ON t.category_id=c.id
    LEFT JOIN web_forum_posts p ON p.topic_id=t.id GROUP BY c.id ORDER BY c.sort_order,c.id`);
  res.json({ categories:rows });
}));

app.get('/api/forum/topics', requireForum, asyncRoute(async (req, res) => {
  const category = Math.max(0, Number(req.query.category) || 0);
  const q = cleanText(req.query.q, 80);
  const page = Math.max(1, Math.min(1000, Number(req.query.page) || 1));
  const params=[], clauses=[];
  if(category){clauses.push('t.category_id=?');params.push(category);}
  if(q){clauses.push('(t.title LIKE ? OR t.author_ucp LIKE ?)');params.push(`%${q}%`,`%${q}%`);}
  const where=clauses.length?`WHERE ${clauses.join(' AND ')}`:'';
  const [rows]=await database().execute(`SELECT t.id,t.category_id,t.author_ucp,t.title,t.pinned,t.locked,t.views,t.created_at,t.updated_at,
    c.name category_name, COUNT(p.id) replies FROM web_forum_topics t JOIN web_forum_categories c ON c.id=t.category_id
    LEFT JOIN web_forum_posts p ON p.topic_id=t.id ${where} GROUP BY t.id ORDER BY t.pinned DESC,t.updated_at DESC LIMIT 25 OFFSET ${(page-1)*25}`,params);
  res.json({topics:rows,page});
}));

app.get('/api/forum/topics/:id', requireForum, asyncRoute(async (req,res)=>{
  const id=Number(req.params.id); if(!Number.isInteger(id)||id<1)return res.status(400).json({error:'Topic ID tidak valid.'});
  await database().execute('UPDATE web_forum_topics SET views=views+1 WHERE id=?',[id]);
  const [topics]=await database().execute(`SELECT t.*,c.name category_name FROM web_forum_topics t JOIN web_forum_categories c ON c.id=t.category_id WHERE t.id=? LIMIT 1`,[id]);
  if(!topics[0])return res.status(404).json({error:'Topic tidak ditemukan.'});
  const [posts]=await database().execute('SELECT id,author_ucp,content,created_at,updated_at FROM web_forum_posts WHERE topic_id=? ORDER BY created_at,id LIMIT 200',[id]);
  res.json({topic:topics[0],posts});
}));

app.post('/api/forum/topics', requireAuth, requireForum, asyncRoute(async(req,res)=>{
  const categoryId=Number(req.body.categoryId),title=cleanText(req.body.title,120),content=cleanText(req.body.content,5000);
  if(!Number.isInteger(categoryId)||title.length<5||content.length<10)return res.status(400).json({error:'Kategori, judul minimal 5 karakter, dan isi minimal 10 karakter wajib diisi.'});
  const [categories]=await database().execute('SELECT admin_only FROM web_forum_categories WHERE id=? LIMIT 1',[categoryId]);
  if(!categories[0])return res.status(404).json({error:'Kategori tidak ditemukan.'});
  if(categories[0].admin_only && await effectiveAdminLevel(req.session.user.id)<1)return res.status(403).json({error:'Kategori khusus administrator.'});
  const [result]=await database().execute('INSERT INTO web_forum_topics (category_id,author_ucp,title,content) VALUES (?,?,?,?)',[categoryId,req.session.user.username,title,content]);
  res.status(201).json({ok:true,id:result.insertId});
}));

app.post('/api/forum/topics/:id/posts', requireAuth, requireForum, asyncRoute(async(req,res)=>{
  const id=Number(req.params.id),content=cleanText(req.body.content,5000);
  if(!Number.isInteger(id)||content.length<2)return res.status(400).json({error:'Balasan tidak valid.'});
  const [topics]=await database().execute('SELECT locked FROM web_forum_topics WHERE id=? LIMIT 1',[id]);
  if(!topics[0])return res.status(404).json({error:'Topic tidak ditemukan.'});
  if(topics[0].locked && await effectiveAdminLevel(req.session.user.id)<1)return res.status(403).json({error:'Topic telah dikunci.'});
  await database().execute('INSERT INTO web_forum_posts (topic_id,author_ucp,content) VALUES (?,?,?)',[id,req.session.user.username,content]);
  await database().execute('UPDATE web_forum_topics SET updated_at=CURRENT_TIMESTAMP WHERE id=?',[id]);
  res.status(201).json({ok:true});
}));

app.patch('/api/forum/topics/:id/moderation', requireAdmin, requireForum, asyncRoute(async(req,res)=>{
  const id=Number(req.params.id), pinned=req.body.pinned?1:0, locked=req.body.locked?1:0;
  const [result]=await database().execute('UPDATE web_forum_topics SET pinned=?,locked=? WHERE id=?',[pinned,locked,id]);
  if(!result.affectedRows)return res.status(404).json({error:'Topic tidak ditemukan.'});
  res.json({ok:true,pinned:Boolean(pinned),locked:Boolean(locked)});
}));

app.get('/api/admin/overview', requireAdmin, asyncRoute(async (req, res) => {
  const q = cleanText(req.query.q, 25);
  const page = Math.max(1, Math.min(10000, Number(req.query.page) || 1));
  const limit = 20;
  const offset = (page - 1) * limit;
  const search = q ? `WHERE u.username LIKE ? OR u.discordid LIKE ?` : '';
  const params = q ? [`%${q}%`, `%${q}%`] : [];
  const [[counts], [accounts], [totalRows]] = await Promise.all([
    database().query(`SELECT
      (SELECT COUNT(*) FROM ucp) ucps,
      (SELECT COUNT(*) FROM ucp WHERE verifystatus=0) pending,
      (SELECT COUNT(*) FROM players) characters,
      (SELECT COUNT(*) FROM players WHERE admin>0) admins,
      (SELECT COUNT(*) FROM vehicle) vehicles,
      (SELECT COUNT(*) FROM houses) houses,
      (SELECT COUNT(*) FROM bisnis) businesses,
      (SELECT COUNT(*) FROM familys) families`),
    database().execute(`SELECT u.id, u.username, u.discordid, u.verifystatus, u.admin, u.registerdate,
      COUNT(p.reg_id) characters, COALESCE(MAX(p.admin),0) game_admin, COALESCE(MAX(p.last_login),'-') last_login
      FROM ucp u LEFT JOIN players p ON p.ucp=u.username ${search}
      GROUP BY u.id, u.username, u.discordid, u.verifystatus, u.admin, u.registerdate
      ORDER BY u.id DESC LIMIT ${limit} OFFSET ${offset}`, params),
    database().execute(`SELECT COUNT(*) total FROM ucp u ${search}`, params)
  ]);
  res.json({ adminLevel:req.adminLevel, counts, accounts, page, pages:Math.max(1, Math.ceil(totalRows[0].total/limit)) });
}));

app.patch('/api/admin/ucp/:id/verification', requireAdmin, asyncRoute(async (req, res) => {
  const id = Number(req.params.id);
  const verified = req.body.verified === true || req.body.verified === 1;
  if (!Number.isInteger(id) || id < 1) return res.status(400).json({ error:'ID UCP tidak valid.' });
  const [result] = await database().execute('UPDATE ucp SET verifystatus = ? WHERE id = ?', [verified ? 1 : 0, id]);
  if (!result.affectedRows) return res.status(404).json({ error:'UCP tidak ditemukan.' });
  await database().execute('INSERT INTO logstaff (command, admin, adminid, player, playerid, str, time) VALUES (?, ?, -1, ?, ?, ?, ?)',
    ['WEBVERIFY', req.session.user.username, `UCP#${id}`, id, verified ? 'verified' : 'unverified', Math.floor(Date.now()/1000)]).catch(()=>{});
  res.json({ ok:true, verified });
}));

app.patch('/api/admin/ucp/:id/discord', requireAdmin, asyncRoute(async (req, res) => {
  const id = Number(req.params.id);
  const discordId = cleanText(req.body.discordId, 32);
  if (!Number.isInteger(id) || id < 1 || !/^\d{17,20}$/.test(discordId)) return res.status(400).json({ error:'ID UCP atau Discord ID tidak valid.' });
  const [used] = await database().execute('SELECT id FROM ucp WHERE discordid = ? AND id != ? LIMIT 1', [discordId, id]);
  if (used.length) return res.status(409).json({ error:'Discord ID sudah digunakan UCP lain.' });
  const verifyCode = `HP-${crypto.randomInt(100000, 999999)}`;
  const [result] = await database().execute('UPDATE ucp SET discordid = ?, verifystatus = 0, verifycode = ? WHERE id = ?', [discordId, verifyCode, id]);
  if (!result.affectedRows) return res.status(404).json({ error:'UCP tidak ditemukan.' });
  res.json({ ok:true, verifyCode });
}));

app.post('/api/admin/ucp/:id/reset-verification', requireAdmin, asyncRoute(async (req, res) => {
  const id = Number(req.params.id);
  if (!Number.isInteger(id) || id < 1) return res.status(400).json({ error:'ID UCP tidak valid.' });
  const verifyCode = `HP-${crypto.randomInt(100000, 999999)}`;
  const [result] = await database().execute('UPDATE ucp SET verifystatus = 0, verifycode = ? WHERE id = ?', [verifyCode, id]);
  if (!result.affectedRows) return res.status(404).json({ error:'UCP tidak ditemukan.' });
  res.json({ ok:true, verifyCode });
}));

app.get('/api/admin/insights', requireAdmin, asyncRoute(async(req,res)=>{
  const [logs,blacklist,vouchers,families,workshops,jobs,factions,vips,sanctions,items,economy,businesses] = await Promise.all([
    database().query('SELECT command,admin,player,str,time FROM logstaff ORDER BY time DESC LIMIT 15'),
    database().query('SELECT username,player,bannedby,reason,banned_date,banned_expired FROM blacklist ORDER BY banned_expired DESC LIMIT 15'),
    database().query('SELECT id,code,vip,vip_time,gold,admin,expired FROM vouchers ORDER BY id DESC LIMIT 15'),
    database().query('SELECT ID id,name,leader,money,component,material FROM familys ORDER BY ID DESC LIMIT 15'),
    database().query('SELECT id,name,owner,ownerid,status,price,money,component,material FROM workshop ORDER BY id DESC LIMIT 15'),
    database().query('SELECT job,COUNT(*) total FROM players GROUP BY job ORDER BY total DESC LIMIT 10'),
    database().query('SELECT faction,COUNT(*) total FROM players GROUP BY faction ORDER BY total DESC LIMIT 10'),
    database().query('SELECT reg_id,username,ucp,vip,vip_time,last_login FROM players WHERE vip>0 ORDER BY vip DESC,vip_time DESC LIMIT 15'),
    database().query('SELECT reg_id,username,warn,jail,jail_time,last_login FROM players WHERE warn>0 OR jail>0 ORDER BY warn DESC,jail DESC LIMIT 15'),
    database().query('SELECT item,SUM(quantity) quantity,COUNT(DISTINCT ownerid) owners FROM inventory GROUP BY item ORDER BY quantity DESC LIMIT 15'),
    database().query('SELECT servermoney,material,materialprice,component,componentprice,gasoil,gasoilprice,product,productprice,food,foodprice,hopecoin,hopecoinprice FROM server LIMIT 1'),
    database().query('SELECT ID id,name,owner,type,price,locked,money,prod FROM bisnis ORDER BY ID DESC LIMIT 20')
  ]);
  const [[dbSize]]=await database().execute('SELECT ROUND(COALESCE(SUM(data_length+index_length),0)/1024/1024,2) size_mb,COUNT(*) tables FROM information_schema.tables WHERE table_schema=?',[process.env.DB_NAME||'hope']);
  res.json({logs:logs[0],blacklist:blacklist[0],vouchers:vouchers[0],families:families[0],workshops:workshops[0],jobs:jobs[0],factions:factions[0],vips:vips[0],sanctions:sanctions[0],items:items[0],economy:economy[0][0]||{},businesses:businesses[0],database:dbSize});
}));

app.get('/api/admin/export/ucp.csv', requireAdmin, asyncRoute(async(req,res)=>{
  const [rows]=await database().query(`SELECT u.id,u.username,u.discordid,u.verifystatus,u.admin,u.registerdate,COUNT(p.reg_id) characters,COALESCE(MAX(p.admin),0) game_admin FROM ucp u LEFT JOIN players p ON p.ucp=u.username GROUP BY u.id ORDER BY u.id`);
  const csv=['id,username,discordid,verified,ucp_admin,registered,characters,game_admin',...rows.map(r=>[r.id,r.username,r.discordid,r.verifystatus,r.admin,r.registerdate,r.characters,r.game_admin].map(v=>`"${String(v??'').replaceAll('"','""')}"`).join(','))].join('\n');
  res.set({'Content-Type':'text/csv; charset=utf-8','Content-Disposition':`attachment; filename="hope-ucp-${new Date().toISOString().slice(0,10)}.csv"`,'Cache-Control':'no-store'}).send('\uFEFF'+csv);
}));

app.get('/api/admin/staff', requireAdmin, asyncRoute(async(req,res)=>{
  const [rows]=await database().query(`SELECT p.reg_id,p.username,p.ucp,p.admin,p.helper,p.level,p.hours,p.faction,p.factionrank,p.last_login,
    u.discordid,u.verifystatus FROM players p LEFT JOIN ucp u ON u.username=p.ucp WHERE p.admin>0 OR p.helper>0 ORDER BY p.admin DESC,p.helper DESC,p.username`);
  res.json({staff:rows,total:rows.length});
}));

const backupLimiter=rateLimit({windowMs:60*60*1000,limit:5,standardHeaders:'draft-8',legacyHeaders:false});
app.get('/api/admin/backup', backupLimiter, requireAdmin, (req,res,next)=>{
  if(!database()||!process.env.DB_HOST)return res.status(503).json({error:'Database belum dikonfigurasi.'});
  const dbName=process.env.DB_NAME||'hope';
  const stamp=new Date().toISOString().replace(/[:.]/g,'-');
  const args=['--single-transaction','--quick','--skip-lock-tables','--default-character-set=utf8mb4',`--host=${process.env.DB_HOST}`,`--port=${Number(process.env.DB_PORT||3306)}`,`--user=${process.env.DB_USER}`,dbName];
  const dump=spawn('mariadb-dump',args,{env:{...process.env,MYSQL_PWD:process.env.DB_PASSWORD||''},stdio:['ignore','pipe','pipe']});
  let started=false,stderr='';
  dump.on('spawn',()=>{started=true;res.set({'Content-Type':'application/sql; charset=utf-8','Content-Disposition':`attachment; filename="hope-backup-${stamp}.sql"`,'Cache-Control':'no-store','X-Content-Type-Options':'nosniff'});dump.stdout.pipe(res);});
  dump.stderr.on('data',chunk=>{stderr+=chunk.toString().slice(0,2000)});
  dump.on('error',error=>{if(!res.headersSent)res.status(500).json({error:'mariadb-dump tidak tersedia. Pastikan paket mariadb terpasang.'});else res.destroy(error);});
  dump.on('close',code=>{if(code!==0){console.error('[BACKUP]',stderr);if(!res.headersSent)res.status(500).json({error:'Backup database gagal.'});}else if(started&&!res.writableEnded)res.end();});
  res.on('close',()=>{if(!res.writableEnded&&!dump.killed)dump.kill('SIGTERM')});
});

app.post('/api/admin/businesses', requireAdmin, asyncRoute(async (req, res) => {
  const name = cleanText(req.body.name, 40);
  const type = Number(req.body.type);
  const price = Math.max(0, Math.min(2000000000, Number(req.body.price) || 0));
  const x = Number(req.body.x || 0), y = Number(req.body.y || 0), z = Number(req.body.z || 0);
  if (name.length < 3 || ![1,2,3,4].includes(type)) return res.status(400).json({ error:'Nama atau jenis bisnis tidak valid.' });
  if (![x,y,z].every(Number.isFinite)) return res.status(400).json({ error:'Koordinat bisnis tidak valid.' });
  await database().execute(`INSERT INTO bisnis (ID,name,type,price,extposx,extposy,extposz,owner,locked,prod)
    SELECT COALESCE(MAX(ID),-1)+1,?,?,?,?,?,?,'-',1,50 FROM bisnis`, [name,type,price,x,y,z]);
  const [[created]] = await database().query('SELECT ID id,name,type,price FROM bisnis ORDER BY ID DESC LIMIT 1');
  res.status(201).json({ ok:true, business:created });
}));

app.post('/api/admin/vouchers', requireAdmin, asyncRoute(async (req, res) => {
  const code = cleanText(req.body.code, 32).toUpperCase();
  const vip = Math.max(0, Math.min(3, Number(req.body.vip) || 0));
  const vipDays = Math.max(0, Math.min(365, Number(req.body.vipDays) || 0));
  const gold = Math.max(0, Math.min(100000000, Number(req.body.gold) || 0));
  const expiresDays = Math.max(1, Math.min(365, Number(req.body.expiresDays) || 30));
  if (!/^[A-Z0-9_-]{4,32}$/.test(code)) return res.status(400).json({ error:'Kode voucher harus 4–32 karakter: huruf, angka, _ atau -.' });
  const [used] = await database().execute('SELECT id FROM vouchers WHERE code=? LIMIT 1',[code]);
  if (used.length) return res.status(409).json({ error:'Kode voucher sudah digunakan.' });
  const vipTime = vipDays ? Math.floor(Date.now()/1000) + vipDays*86400 : 0;
  const expired = Math.floor(Date.now()/1000) + expiresDays*86400;
  await database().execute(`INSERT INTO vouchers (id,code,vip,vip_time,gold,admin,expired)
    SELECT COALESCE(MAX(id),0)+1,?,?,?,?,?,? FROM vouchers`,[code,vip,vipTime,gold,req.session.user.username.slice(0,16),expired]);
  res.status(201).json({ ok:true, code });
}));

app.post('/api/admin/families', requireAdmin, asyncRoute(async (req, res) => {
  const name=cleanText(req.body.name,50), leader=cleanText(req.body.leader,50), motd=cleanText(req.body.motd,100) || 'Welcome to the family';
  const color=Math.max(0,Number(req.body.color)||0);
  if(name.length<3 || leader.length<3) return res.status(400).json({error:'Nama family dan leader wajib diisi.'});
  const [player]=await database().execute('SELECT reg_id FROM players WHERE username=? LIMIT 1',[leader]);
  if(!player.length) return res.status(404).json({error:'Character leader tidak ditemukan.'});
  await database().execute(`INSERT INTO familys (ID,name,leader,motd,color) SELECT COALESCE(MAX(ID),-1)+1,?,?,?,? FROM familys`,[name,leader,motd,color]);
  const [[family]]=await database().query('SELECT ID id,name,leader FROM familys ORDER BY ID DESC LIMIT 1');
  res.status(201).json({ok:true,family});
}));

app.get('/api/admin/player', requireAdmin, asyncRoute(async (req, res) => {
  const name = cleanText(req.query.name, 24);
  if (!name) return res.status(400).json({ error:'Masukkan nama character.' });
  const [rows] = await database().execute(`SELECT reg_id, username, ucp, admin, helper, level, vip, money, bmoney,
    hours, minutes, faction, factionrank, factionlead, family, familyrank, job, job2, phone, warn, jail,
    jail_time, health, armour, hunger, energy, reg_date, last_login FROM players WHERE username = ? LIMIT 1`, [name]);
  if (!rows[0]) return res.status(404).json({ error:'Character tidak ditemukan.' });
  res.json({ player:rows[0] });
}));

app.use(express.static(path.join(__dirname, 'public'), { maxAge: isProduction ? '7d' : 0 }));
app.get('/{*splat}', (req, res) => res.sendFile(path.join(__dirname, 'public', 'index.html')));
app.use((err, req, res, next) => {
  console.error(err);
  if (res.headersSent) return next(err);
  res.status(500).json({ error: isProduction ? 'Terjadi kesalahan pada server.' : err.message });
});

app.listen(PORT, '0.0.0.0', () => console.log(`Hope Pride Roleplay berjalan di http://0.0.0.0:${PORT}`));
