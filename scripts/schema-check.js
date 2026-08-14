'use strict';

// Contract test: memastikan query website/bot hanya memakai tabel dan kolom
// yang benar-benar tersedia pada dump hope.sql.
const fs = require('fs');
const path = require('path');
const sql = fs.readFileSync(path.join(__dirname, '..', 'hope.sql'), 'utf8').replace(/\r/g, '');
const schema = new Map();
const tablePattern = /CREATE TABLE `([^`]+)` \(([^;]+?)\n\) ENGINE=/gms;
let match;
while ((match = tablePattern.exec(sql))) {
  const columns = new Set();
  for (const line of match[2].split('\n')) {
    const column = line.match(/^\s*`([^`]+)`\s+/);
    if (column) columns.add(column[1]);
  }
  schema.set(match[1], columns);
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
  workshop: ['id','owner','ownerid','name','status','price'],
  blacklist: ['username','player','bannedby','reason','banned_date','banned_expired'],
  player_skill: ['id','owner','name','level','exp'],
  player_fish: ['id','owner','name','weight'],
  toys: ['Id','Owner'],
  vehicle_keys: ['id','owner','vehicle'],
  claimvoucher: ['playerid','code'],
  requestcs: ['name','user']
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

if (schema.size !== 46) errors.push(`Dump terbaca ${schema.size} tabel; seharusnya 46 tabel`);
if (errors.length) {
  console.error('Schema contract GAGAL:\n- ' + errors.join('\n- '));
  process.exit(1);
}
console.log(`Schema contract OK — ${schema.size} tabel, ${Object.keys(contract).length} tabel aplikasi tervalidasi.`);
