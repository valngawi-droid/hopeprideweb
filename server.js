'use strict';

require('dotenv').config();
const path = require('path');
const crypto = require('crypto');
const express = require('express');
const helmet = require('helmet');
const session = require('express-session');
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
app.use(session({
  name: 'hope.sid',
  secret: process.env.SESSION_SECRET || 'development-only-change-this-secret',
  resave: false,
  saveUninitialized: false,
  cookie: { httpOnly: true, sameSite: 'lax', secure: isProduction, maxAge: 1000 * 60 * 60 * 12 }
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
      charset: 'latin1'
    });
  }
  return pool;
}

const demoDashboard = {
  ucp: { username: 'HopePlayer', verified: true, admin: 0, discordId: '123456789012345678', registered: '14 Agu 2026' },
  characters: [
    { id: 18, name: 'Raka_Pride', level: 27, hours: 146, money: 128450, bank: 742500, phone: 88021, job: 'Mechanic', faction: 'San Andreas Police', factionRank: 3, vip: 2, skin: 240, health: 92, armour: 35, hunger: 74, energy: 89, lastLogin: '2026-08-13 22:41:09', vehicles: 3, houses: 1 },
    { id: 21, name: 'Nadia_Harper', level: 12, hours: 54, money: 84200, bank: 215000, phone: 77192, job: 'Trucker', faction: 'Civilian', factionRank: 0, vip: 0, skin: 211, health: 100, armour: 0, hunger: 93, energy: 78, lastLogin: '2026-08-12 19:12:30', vehicles: 1, houses: 0 }
  ],
  vehicles: [
    { id: 311, owner: 'Raka_Pride', model: 560, name: 'Sultan', plate: 'HPR 042', health: 987, fuel: 84, locked: true },
    { id: 317, owner: 'Raka_Pride', model: 468, name: 'Sanchez', plate: 'HPR 218', health: 901, fuel: 61, locked: false },
    { id: 328, owner: 'Nadia_Harper', model: 515, name: 'Roadtrain', plate: 'HPR 991', health: 932, fuel: 47, locked: true }
  ],
  properties: [{ id: 129, owner: 'Raka_Pride', address: 'Vinewood Residence #129', price: 950000, locked: true }],
  inventory: [{ item: 'Medkit', quantity: 4 }, { item: 'Food', quantity: 12 }, { item: 'Repair Kit', quantity: 2 }, { item: 'Phone', quantity: 1 }],
  salaries: [{ info: 'San Andreas Police — Paycheck', money: 4250, date: '2026-08-13' }]
};

const vehicleNames = { 400:'Landstalker', 411:'Infernus', 415:'Cheetah', 421:'Washington', 426:'Premier', 429:'Banshee', 445:'Admiral', 451:'Turismo', 468:'Sanchez', 475:'Sabre', 496:'Blista Compact', 507:'Elegant', 515:'Roadtrain', 522:'NRG-500', 541:'Bullet', 560:'Sultan', 562:'Elegy', 565:'Flash', 579:'Huntley' };
const jobNames = ['Unemployed','Trucker','Bus Driver','Mechanic','Farmer','Fisherman','Miner','Lumberjack','Taxi Driver','Courier','Milkman'];
const factionNames = ['Civilian','San Andreas Police','San Andreas Government','San Andreas Medical','San Andreas News','San Andreas Judiciary'];

function publicStatsFallback() {
  return { players: 43, ucps: 23, vehicles: 393, properties: 303, businesses: 27, online: 0, database: 'demo' };
}
function clientIp(req) { return String(req.ip || '').replace('::ffff:', '').slice(0, 17) || '127.0.0.1'; }
function cleanText(value, max = 32) { return String(value || '').trim().slice(0, max); }
function requireAuth(req, res, next) { return req.session.user ? next() : res.status(401).json({ error: 'Silakan masuk ke UCP terlebih dahulu.' }); }
function asyncRoute(fn) { return (req, res, next) => Promise.resolve(fn(req, res, next)).catch(next); }

app.get('/api/health', asyncRoute(async (req, res) => {
  let db = 'not-configured';
  try { if (database()) { await database().query('SELECT 1'); db = 'connected'; } } catch { db = 'unavailable'; }
  res.json({ ok: true, database: db, service: 'Hope Pride Roleplay' });
}));

app.get('/api/public', asyncRoute(async (req, res) => {
  if (!database()) return res.json(publicStatsFallback());
  try {
    const [[players], [ucps], [vehicles], [houses], [businesses]] = await Promise.all([
      database().query('SELECT COUNT(*) total FROM players'), database().query('SELECT COUNT(*) total FROM ucp'),
      database().query('SELECT COUNT(*) total FROM vehicle'), database().query('SELECT COUNT(*) total FROM houses'),
      database().query('SELECT COUNT(*) total FROM bisnis')
    ]);
    res.json({ players: players[0].total, ucps: ucps[0].total, vehicles: vehicles[0].total, properties: houses[0].total, businesses: businesses[0].total, online: 0, database: 'live' });
  } catch { res.json(publicStatsFallback()); }
}));

app.get('/api/session', (req, res) => res.json({ authenticated: Boolean(req.session.user), user: req.session.user || null }));

app.post('/api/auth/login', asyncRoute(async (req, res) => {
  const username = cleanText(req.body.username, 25);
  const password = String(req.body.password || '');
  if (!username || !password) return res.status(400).json({ error: 'Username dan password wajib diisi.' });
  if (!database()) return res.status(503).json({ error: 'Database belum dikonfigurasi. Gunakan mode demo untuk melihat UCP.' });
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
  res.status(201).json({ ok: true, verifyCode, message: 'UCP dibuat. Kirim kode verifikasi ke bot Discord Hope Pride.' });
}));

app.post('/api/auth/logout', (req, res) => req.session.destroy(() => res.json({ ok: true })));
app.get('/api/demo', (req, res) => res.json(demoDashboard));

app.get('/api/me', requireAuth, asyncRoute(async (req, res) => {
  const db = database();
  const [[ucpRows], [characters]] = await Promise.all([
    db.execute('SELECT username, admin, verifystatus, discordid, registerdate FROM ucp WHERE id = ? LIMIT 1', [req.session.user.id]),
    db.execute(`SELECT reg_id, username, level, hours, minutes, money, bmoney, phone, job, faction, factionrank, vip, skin, health, armour, hunger, energy, last_login FROM players WHERE ucp = ? ORDER BY reg_id`, [req.session.user.username])
  ]);
  const names = characters.map(c => c.username);
  const ids = characters.map(c => c.reg_id);
  let vehicles = [], properties = [], inventory = [], salaries = [];
  if (names.length) {
    const marks = names.map(() => '?').join(',');
    [properties] = await db.query(`SELECT ID id, owner, address, price, locked FROM houses WHERE owner IN (${marks}) ORDER BY ID DESC`, names);
  }
  if (ids.length) {
    const marks = ids.map(() => '?').join(',');
    [vehicles] = await db.query(`SELECT id, owner, model, plate, health, fuel, locked FROM vehicle WHERE owner IN (${marks}) ORDER BY id DESC`, ids);
    [inventory] = await db.query(`SELECT item, SUM(quantity) quantity FROM inventory WHERE ownerid IN (${marks}) GROUP BY item ORDER BY quantity DESC LIMIT 24`, ids);
    [salaries] = await db.query(`SELECT info, money, date FROM salary WHERE owner IN (${marks}) ORDER BY id DESC LIMIT 10`, ids);
  }
  res.json({
    ucp: { username: ucpRows[0].username, verified: Boolean(ucpRows[0].verifystatus), admin: Number(ucpRows[0].admin), discordId: ucpRows[0].discordid, registered: ucpRows[0].registerdate },
    characters: characters.map(c => ({ id:c.reg_id, name:c.username, level:c.level, hours:c.hours, minutes:c.minutes, money:c.money, bank:c.bmoney, phone:c.phone, job:jobNames[c.job] || `Job ${c.job}`, faction:factionNames[c.faction] || `Faction ${c.faction}`, factionRank:c.factionrank, vip:c.vip, skin:c.skin, health:c.health, armour:c.armour, hunger:c.hunger, energy:c.energy, lastLogin:c.last_login, vehicles:vehicles.filter(v=>Number(v.owner)===Number(c.reg_id)).length, houses:properties.filter(h=>h.owner===c.username).length })),
    vehicles: vehicles.map(v => ({ ...v, owner: characters.find(c => Number(c.reg_id) === Number(v.owner))?.username || `Character #${v.owner}`, name: vehicleNames[v.model] || `Vehicle ${v.model}`, locked: Boolean(v.locked) })),
    properties: properties.map(h => ({ ...h, locked: Boolean(h.locked) })), inventory, salaries
  });
}));

app.use(express.static(path.join(__dirname, 'public'), { maxAge: isProduction ? '7d' : 0 }));
app.get('/{*splat}', (req, res) => res.sendFile(path.join(__dirname, 'public', 'index.html')));
app.use((err, req, res, next) => {
  console.error(err);
  if (res.headersSent) return next(err);
  res.status(500).json({ error: isProduction ? 'Terjadi kesalahan pada server.' : err.message });
});

app.listen(PORT, '0.0.0.0', () => console.log(`Hope Pride Roleplay berjalan di http://0.0.0.0:${PORT}`));
