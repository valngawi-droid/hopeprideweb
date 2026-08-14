'use strict';

// Contract test: memastikan query website/bot hanya memakai tabel dan kolom
// yang benar-benar tersedia pada dump hope.sql.
const fs = require('fs');
const path = require('path');
const baseSql = fs.readFileSync(path.join(__dirname, '..', 'hope.sql'), 'utf8').replace(/\r/g, '');
const webSql = fs.readFileSync(path.join(__dirname, '..', 'migrations', '001_web_forum.sql'), 'utf8').replace(/\r/g, '');
const schema = new Map();
const tablePattern = /CREATE TABLE(?: IF NOT EXISTS)? `([^`]+)` \(([^;]+?)\n\) ENGINE=/gms;
let match;
for (const sql of [baseSql, webSql]) {
  tablePattern.lastIndex = 0;
  while ((match = tablePattern.exec(sql))) {
    const columns = new Set();
    for (const line of match[2].split('\n')) {
      const column = line.match(/^\s*`([^`]+)`\s+/);
      if (column) columns.add(column[1]);
    }
    schema.set(match[1], columns);
  }
}

const contract = {
  ucp: ['id','username','password','ip','admin','verifystatus','verifycode','discordid','registerdate'],
  players: ['reg_id','username','ucp','adminname','admin','helper','level','vip','money','bmoney','phone','hours','minutes','skin','health','armour','hunger','energy','faction','factionrank','factionlead','family','familyrank','job','job2','warn','jail','jail_time','reg_date','last_login'],
  vehicle: ['id','owner','model','plate','health','fuel','locked'],
  houses: ['ID','owner','address','price','locked'],
  bisnis: ['ID','owner','name','price','type','locked','money','prod','restock','extposx','extposy','extposz'],
  inventory: ['id','ownerid','item','quantity'],
  salary: ['id','owner','info','money','date'],
  familys: ['ID','name','leader','motd','color'],
  vouchers: ['id','code','vip','vip_time','gold','admin','expired'],
  logstaff: ['command','admin','adminid','player','playerid','str','time'],
  workshop: ['id','owner','ownerid','name','status','price','money','component','material'],
  server: ['id','servermoney','material','materialprice','component','componentprice','gasoil','gasoilprice','product','productprice','food','foodprice','hopecoin','hopecoinprice'],
  blacklist: ['username','player','bannedby','reason','banned_date','banned_expired'],
  player_skill: ['id','owner','name','level','exp'],
  player_fish: ['id','owner','name','weight'],
  toys: ['Id','Owner'],
  vehicle_keys: ['id','owner','vehicle'],
  claimvoucher: ['playerid','code'],
  requestcs: ['name','user'],
  web_sessions: ['session_id','expires','data'],
  web_forum_categories: ['id','slug','name','description','icon','sort_order','admin_only','created_at'],
  web_forum_topics: ['id','category_id','author_ucp','title','content','pinned','locked','views','created_at','updated_at'],
  web_forum_posts: ['id','topic_id','author_ucp','content','created_at','updated_at']
};

const errors = [];
for (const [table, requiredColumns] of Object.entries(contract)) {
  const available = schema.get(table);
  if (!available) {
    errors.push(`Tabel \`${table}\` tidak ditemukan`);
    continue;
  }
  for (const column of requiredColumns) {
    if (!available.has(column)) errors.push(`Kolom \`${table}.${column}\` tidak ditemukan`);
  }
}

const baseTableCount = (baseSql.match(/CREATE TABLE `/g) || []).length;
if (baseTableCount !== 46) errors.push(`hope.sql terbaca ${baseTableCount} tabel; seharusnya 46 tabel`);
if (schema.size !== 50) errors.push(`Total schema terbaca ${schema.size} tabel; seharusnya 50 termasuk session dan forum`);
if (errors.length) {
  console.error('Schema contract GAGAL:\n- ' + errors.join('\n- '));
  process.exit(1);
}
console.log(`Schema contract OK — 46 tabel game + 4 tabel web, ${Object.keys(contract).length} tabel aplikasi tervalidasi.`);
