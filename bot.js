'use strict';

require('dotenv').config();
const mysql = require('mysql2/promise');
const bcrypt = require('bcryptjs');
const crypto = require('crypto');
const {
  Client, GatewayIntentBits, REST, Routes, SlashCommandBuilder,
  EmbedBuilder, PermissionFlagsBits, MessageFlags
} = require('discord.js');

const required = ['DISCORD_TOKEN', 'DISCORD_CLIENT_ID', 'DB_HOST', 'DB_USER', 'DB_NAME'];
const missing = required.filter(key => !process.env[key]);
if (missing.length) {
  console.error(`[BOT] Konfigurasi belum lengkap: ${missing.join(', ')}`);
  console.error('[BOT] Isi .env dan gunakan token BARU dari Discord Developer Portal.');
  process.exit(1);
}

const db = mysql.createPool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME || 'hope',
  waitForConnections: true,
  connectionLimit: 4,
  charset: 'utf8mb4'
});

const commands = [
  new SlashCommandBuilder().setName('id').setDescription('Lihat Discord User ID milikmu.'),
  new SlashCommandBuilder().setName('verify').setDescription('Verifikasi UCP Hope Pride melalui Discord.')
    .addStringOption(o => o.setName('kode').setDescription('Kode HP-xxxxxx dari pendaftaran UCP').setRequired(true).setMinLength(9).setMaxLength(16)),
  new SlashCommandBuilder().setName('akun').setDescription('Lihat informasi UCP dan jumlah character milikmu.'),
  new SlashCommandBuilder().setName('karakter').setDescription('Lihat daftar atau detail character IC milikmu.')
    .addStringOption(o => o.setName('nama').setDescription('Nama IC, contoh Raka_Pride').setRequired(false).setMaxLength(24)),
  new SlashCommandBuilder().setName('server').setDescription('Lihat statistik database Hope Pride.'),
  new SlashCommandBuilder().setName('bantuan').setDescription('Lihat daftar command Hope Pride Bot.'),
  new SlashCommandBuilder().setName('aset').setDescription('Lihat jumlah kendaraan, rumah, dan bisnis milikmu.'),
  new SlashCommandBuilder().setName('inventori').setDescription('Lihat inventori sebuah character IC milikmu.')
    .addStringOption(o => o.setName('karakter').setDescription('Nama character IC').setRequired(true).setMaxLength(24)),
  new SlashCommandBuilder().setName('leaderboard').setDescription('Peringkat character Hope Pride.')
    .addStringOption(o => o.setName('kategori').setDescription('Kategori peringkat').setRequired(true).addChoices(
      { name:'Level tertinggi', value:'level' }, { name:'Jam bermain', value:'hours' }
    )),
  new SlashCommandBuilder().setName('request-cs').setDescription('Ajukan Character Story untuk character milikmu.')
    .addStringOption(o=>o.setName('character').setDescription('Nama Character IC').setRequired(true).setMaxLength(24)),
  new SlashCommandBuilder().setName('reset-password').setDescription('Ganti password UCP melalui Discord terhubung.')
    .addStringOption(o => o.setName('password_baru').setDescription('Minimal 8 karakter').setRequired(true).setMinLength(8).setMaxLength(72))
    .addStringOption(o => o.setName('konfirmasi').setDescription('Ulangi password baru').setRequired(true).setMinLength(8).setMaxLength(72)),
  new SlashCommandBuilder().setName('admin-cmdlogs').setDescription('Lihat log command administrator terbaru.')
    .addStringOption(o=>o.setName('cari').setDescription('Command, admin, atau player').setMaxLength(40)),
  new SlashCommandBuilder().setName('admin-paylogs').setDescription('Monitor transfer besar dan pola transaksi berulang.')
    .addStringOption(o=>o.setName('player').setDescription('Nama player').setMaxLength(24)),
  new SlashCommandBuilder().setName('admin-request-cs').setDescription('Review Request Character Story.')
    .addStringOption(o=>o.setName('character').setDescription('Nama Character').setRequired(true).setMaxLength(24))
    .addStringOption(o=>o.setName('aksi').setDescription('Keputusan').setRequired(true).addChoices({name:'Approve',value:'approve'},{name:'Reject',value:'reject'})),
  new SlashCommandBuilder().setName('admin-stats').setDescription('Statistik lengkap khusus administrator.'),
  new SlashCommandBuilder().setName('admin-ucp').setDescription('Cari dan kelola verifikasi sebuah UCP.')
    .addStringOption(o => o.setName('username').setDescription('Username UCP').setRequired(true).setMaxLength(25))
    .addStringOption(o => o.setName('aksi').setDescription('Tindakan admin').setRequired(true).addChoices(
      { name: 'Lihat informasi', value: 'info' }, { name: 'Verifikasi', value: 'verify' }, { name: 'Batalkan verifikasi', value: 'unverify' }
    )),
  new SlashCommandBuilder().setName('admin-player').setDescription('Lihat data character IC untuk administrasi.')
    .addStringOption(o => o.setName('nama').setDescription('Nama character IC').setRequired(true).setMaxLength(24)),
  new SlashCommandBuilder().setName('admin-cari').setDescription('Cari UCP berdasarkan username, Discord ID, atau character.')
    .addStringOption(o => o.setName('query').setDescription('Username, Discord ID, atau nama IC').setRequired(true).setMaxLength(32)),
  new SlashCommandBuilder().setName('admin-discord').setDescription('Ganti Discord ID sebuah UCP dan wajibkan verifikasi ulang.')
    .addStringOption(o => o.setName('username').setDescription('Username UCP').setRequired(true).setMaxLength(25))
    .addUserOption(o => o.setName('discord').setDescription('Akun Discord baru').setRequired(true)),
  new SlashCommandBuilder().setName('admin-reset-verifikasi').setDescription('Reset status dan buat kode verifikasi UCP baru.')
    .addStringOption(o => o.setName('username').setDescription('Username UCP').setRequired(true).setMaxLength(25)),
  new SlashCommandBuilder().setName('admin-add-bisnis').setDescription('Tambahkan warung atau toko baru ke database kota.')
    .addStringOption(o=>o.setName('nama').setDescription('Nama bisnis').setRequired(true).setMaxLength(40))
    .addIntegerOption(o=>o.setName('jenis').setDescription('1 Warung, 2 Toko, 3 Baju, 4 Khusus').setRequired(true).setMinValue(1).setMaxValue(4))
    .addIntegerOption(o=>o.setName('harga').setDescription('Harga bisnis').setRequired(true).setMinValue(0))
    .addNumberOption(o=>o.setName('x').setDescription('Posisi X')).addNumberOption(o=>o.setName('y').setDescription('Posisi Y')).addNumberOption(o=>o.setName('z').setDescription('Posisi Z')),
  new SlashCommandBuilder().setName('admin-voucher').setDescription('Buat voucher Gold atau VIP baru.')
    .addStringOption(o=>o.setName('kode').setDescription('Kode voucher').setRequired(true).setMinLength(4).setMaxLength(32))
    .addIntegerOption(o=>o.setName('gold').setDescription('Jumlah Gold').setMinValue(0))
    .addIntegerOption(o=>o.setName('vip').setDescription('VIP level 0–3').setMinValue(0).setMaxValue(3))
    .addIntegerOption(o=>o.setName('hari').setDescription('Durasi dan masa aktif (hari)').setMinValue(1).setMaxValue(365))
].map(c => c.toJSON());

const client = new Client({ intents: [GatewayIntentBits.Guilds] });
const rupiah = value => `Rp${Number(value || 0).toLocaleString('id-ID')}`;
const hidden = MessageFlags.Ephemeral;
const green = 0x36e18d;

function embed(title, description = '') {
  return new EmbedBuilder().setColor(green).setTitle(title).setDescription(description).setFooter({ text: 'Hope Pride Roleplay • UCP System' }).setTimestamp();
}
async function ownUcp(discordId) {
  const [rows] = await db.execute('SELECT id, username, admin, verifystatus, verifycode, discordid, registerdate FROM ucp WHERE discordid = ? ORDER BY id LIMIT 1', [discordId]);
  return rows[0] || null;
}
async function adminLevel(interaction) {
  if (interaction.memberPermissions?.has(PermissionFlagsBits.Administrator)) return 999;
  if (process.env.DISCORD_ADMIN_ROLE_ID && interaction.member?.roles?.cache?.has(process.env.DISCORD_ADMIN_ROLE_ID)) return 999;
  const [rows] = await db.execute(`SELECT GREATEST(COALESCE(u.admin,0), COALESCE(MAX(p.admin),0)) level
    FROM ucp u LEFT JOIN players p ON p.ucp = u.username WHERE u.discordid = ? GROUP BY u.id, u.admin`, [interaction.user.id]);
  return Number(rows[0]?.level || 0);
}
async function requireAdmin(interaction) {
  if (await adminLevel(interaction) > 0) return true;
  await interaction.reply({ content: '⛔ Perintah ini hanya dapat digunakan administrator Hope Pride.', flags: hidden });
  return false;
}

client.once('ready', async () => {
  console.log(`[BOT] Login sebagai ${client.user.tag}`);
  try {
    const rest = new REST({ version: '10' }).setToken(process.env.DISCORD_TOKEN);
    const route = process.env.DISCORD_GUILD_ID
      ? Routes.applicationGuildCommands(process.env.DISCORD_CLIENT_ID, process.env.DISCORD_GUILD_ID)
      : Routes.applicationCommands(process.env.DISCORD_CLIENT_ID);
    await rest.put(route, { body: commands });
    console.log(`[BOT] ${commands.length} slash command berhasil didaftarkan${process.env.DISCORD_GUILD_ID ? ' ke server Discord' : ' secara global'}.`);
  } catch (error) { console.error('[BOT] Gagal mendaftarkan command:', error.message); }
});

client.on('interactionCreate', async interaction => {
  if (!interaction.isChatInputCommand()) return;
  try {
    if (interaction.commandName === 'id') {
      return interaction.reply({ embeds: [embed('Discord ID Kamu', `ID: \`${interaction.user.id}\`\nSalin ID ini saat membuat UCP di website.`).setThumbnail(interaction.user.displayAvatarURL())], flags: hidden });
    }
    if (interaction.commandName === 'verify') {
      const code = interaction.options.getString('kode', true).trim().toUpperCase();
      const [rows] = await db.execute('SELECT id, username, discordid, verifystatus FROM ucp WHERE verifycode = ? LIMIT 1', [code]);
      const account = rows[0];
      if (!account) return interaction.reply({ content: '❌ Kode verifikasi tidak ditemukan.', flags: hidden });
      if (String(account.discordid) !== interaction.user.id) return interaction.reply({ content: '❌ Discord ID akun ini tidak sama dengan Discord ID pendaftaran UCP.', flags: hidden });
      if (Number(account.verifystatus)) return interaction.reply({ content: `✅ UCP **${account.username}** sudah terverifikasi.`, flags: hidden });
      await db.execute('UPDATE ucp SET verifystatus = 1 WHERE id = ?', [account.id]);
      return interaction.reply({ embeds: [embed('Verifikasi Berhasil', `UCP **${account.username}** kini aktif. Kamu sudah dapat login ke website dan membuat character IC.`)], flags: hidden });
    }
    if (interaction.commandName === 'akun') {
      const ucp = await ownUcp(interaction.user.id);
      if (!ucp) return interaction.reply({ content: '❌ Discord ID ini belum terdaftar sebagai UCP.', flags: hidden });
      const [[count]] = await db.execute('SELECT COUNT(*) total, COALESCE(MAX(admin),0) admin FROM players WHERE ucp = ?', [ucp.username]);
      const card = embed(`UCP • ${ucp.username}`).addFields(
        { name:'Status', value:Number(ucp.verifystatus)?'✅ Terverifikasi':'⏳ Belum diverifikasi', inline:true },
        { name:'Character IC', value:String(count.total), inline:true }, { name:'Admin Level', value:String(Math.max(Number(ucp.admin), Number(count.admin))), inline:true },
        { name:'Discord ID', value:`\`${interaction.user.id}\``, inline:false }, { name:'Terdaftar', value:String(ucp.registerdate || '-'), inline:false }
      );
      return interaction.reply({ embeds:[card], flags:hidden });
    }
    if (interaction.commandName === 'karakter') {
      const ucp = await ownUcp(interaction.user.id);
      if (!ucp) return interaction.reply({ content:'❌ UCP tidak ditemukan untuk Discord ID ini.', flags:hidden });
      const name = interaction.options.getString('nama');
      const params = name ? [ucp.username, name] : [ucp.username];
      const [rows] = await db.execute(`SELECT reg_id, username, level, hours, minutes, money, bmoney, phone, job, faction, factionrank, family, vip, admin, helper, last_login FROM players WHERE ucp = ?${name ? ' AND username = ?' : ''} ORDER BY reg_id LIMIT 10`, params);
      if (!rows.length) return interaction.reply({ content:'Belum ada character IC yang cocok.', flags:hidden });
      const text = rows.map(p => `**${p.username}** • Level ${p.level} • ${p.hours} jam\nID ${p.reg_id} • Phone ${p.phone || '-'} • Aset tunai ${rupiah(p.money + p.bmoney)}\nFaction ${p.faction} Rank ${p.factionrank} • Terakhir ${p.last_login}`).join('\n\n');
      return interaction.reply({ embeds:[embed(name ? 'Detail Character IC' : 'Character IC Milikmu', text)], flags:hidden });
    }
    if (interaction.commandName === 'server') {
      const [[p],[u],[v],[h],[b]] = await Promise.all(['players','ucp','vehicle','houses','bisnis'].map(t => db.query(`SELECT COUNT(*) total FROM \`${t}\``)));
      return interaction.reply({ embeds:[embed('Statistik Hope City').addFields(
        {name:'Character',value:String(p[0].total),inline:true},{name:'UCP',value:String(u[0].total),inline:true},{name:'Kendaraan',value:String(v[0].total),inline:true},{name:'Rumah',value:String(h[0].total),inline:true},{name:'Bisnis',value:String(b[0].total),inline:true}
      )] });
    }
    if (interaction.commandName === 'bantuan') {
      return interaction.reply({ embeds:[embed('Hope Pride Bot • Bantuan',
        '**Akun**\n`/id` `/verify` `/akun` `/request-cs` `/reset-password`\n\n**Character & Kota**\n`/karakter` `/aset` `/inventori` `/leaderboard` `/server`\n\n**Administrator**\n`/admin-stats` `/admin-cmdlogs` `/admin-paylogs` `/admin-request-cs` `/admin-ucp` `/admin-player` `/admin-cari` `/admin-discord` `/admin-reset-verifikasi` `/admin-add-bisnis` `/admin-voucher`\n\nSemua informasi privat dikirim secara ephemeral dan dibaca langsung dari database.')], flags:hidden });
    }
    if (interaction.commandName === 'aset') {
      const ucp=await ownUcp(interaction.user.id);
      if(!ucp) return interaction.reply({content:'❌ Discord ID ini belum terhubung ke UCP.',flags:hidden});
      const [[v],[h],[b]] = await Promise.all([
        db.query('SELECT COUNT(*) total FROM vehicle WHERE owner IN (SELECT reg_id FROM players WHERE ucp=?)',[ucp.username]),
        db.query('SELECT COUNT(*) total FROM houses WHERE owner IN (SELECT username FROM players WHERE ucp=?)',[ucp.username]),
        db.query('SELECT COUNT(*) total FROM bisnis WHERE owner IN (SELECT username FROM players WHERE ucp=?)',[ucp.username])
      ]);
      return interaction.reply({embeds:[embed(`Aset • ${ucp.username}`).addFields(
        {name:'Kendaraan',value:String(v[0].total),inline:true},{name:'Rumah',value:String(h[0].total),inline:true},{name:'Bisnis',value:String(b[0].total),inline:true}
      )],flags:hidden});
    }
    if (interaction.commandName === 'inventori') {
      const ucp=await ownUcp(interaction.user.id), name=interaction.options.getString('karakter',true);
      if(!ucp) return interaction.reply({content:'❌ UCP tidak ditemukan.',flags:hidden});
      const [chars]=await db.execute('SELECT reg_id FROM players WHERE ucp=? AND username=? LIMIT 1',[ucp.username,name]);
      if(!chars[0]) return interaction.reply({content:'❌ Character bukan milik UCP ini atau tidak ditemukan.',flags:hidden});
      const [items]=await db.execute('SELECT item, quantity FROM inventory WHERE ownerid=? AND quantity>0 ORDER BY quantity DESC LIMIT 25',[chars[0].reg_id]);
      const text=items.length?items.map(i=>`• **${i.item}** × ${i.quantity}`).join('\n'):'Inventori kosong.';
      return interaction.reply({embeds:[embed(`Inventori • ${name}`,text)],flags:hidden});
    }
    if (interaction.commandName === 'leaderboard') {
      const category=interaction.options.getString('kategori',true);
      const column=category==='hours'?'hours':'level';
      const [rows]=await db.query(`SELECT username, level, hours FROM players ORDER BY \`${column}\` DESC, reg_id ASC LIMIT 10`);
      const text=rows.map((p,i)=>`**${i+1}. ${p.username}** — ${category==='hours'?`${p.hours} jam`:`Level ${p.level}`}`).join('\n');
      return interaction.reply({embeds:[embed(`Leaderboard • ${category==='hours'?'Jam Bermain':'Level'}`,text)]});
    }
    if(interaction.commandName==='request-cs'){
      const ucp=await ownUcp(interaction.user.id),name=interaction.options.getString('character',true);
      if(!ucp)return interaction.reply({content:'Discord ID ini belum terhubung ke UCP.',flags:hidden});
      const [players]=await db.execute('SELECT username,charstory FROM players WHERE username=? AND ucp=? LIMIT 1',[name,ucp.username]);
      if(!players[0])return interaction.reply({content:'Character tidak ditemukan atau bukan milik UCP kamu.',flags:hidden});
      if(Number(players[0].charstory)>0)return interaction.reply({content:'Character Story sudah aktif.',flags:hidden});
      const [existing]=await db.execute('SELECT name FROM requestcs WHERE name=? OR user=? LIMIT 1',[name,ucp.username]);
      if(existing.length)return interaction.reply({content:'Sudah ada Request CS yang menunggu.',flags:hidden});
      await db.execute('INSERT INTO requestcs (name,user) VALUES (?,?)',[name,ucp.username]);
      return interaction.reply({embeds:[embed('Request CS Terkirim',`Character **${name}** masuk antrean review staff.`)],flags:hidden});
    }
    if (interaction.commandName === 'reset-password') {
      const pass=interaction.options.getString('password_baru',true), confirm=interaction.options.getString('konfirmasi',true);
      if(pass!==confirm) return interaction.reply({content:'❌ Konfirmasi password tidak sama.',flags:hidden});
      const ucp=await ownUcp(interaction.user.id);
      if(!ucp || !Number(ucp.verifystatus)) return interaction.reply({content:'❌ Discord ini tidak terhubung ke UCP terverifikasi.',flags:hidden});
      const hash=await bcrypt.hash(pass,12);
      await db.execute('UPDATE ucp SET password=? WHERE id=?',[hash,ucp.id]);
      return interaction.reply({embeds:[embed('Password Berhasil Diubah',`Password UCP **${ucp.username}** telah diperbarui. Jangan pernah membagikan password kepada siapa pun.`)],flags:hidden});
    }
    if(interaction.commandName==='admin-cmdlogs'){
      if(!(await requireAdmin(interaction)))return;const q=interaction.options.getString('cari'),params=[];let where='';if(q){where='WHERE command LIKE ? OR admin LIKE ? OR player LIKE ?';params.push(...Array(3).fill(`%${q}%`));}
      const [rows]=await db.execute(`SELECT command,admin,player,str,time FROM logstaff ${where} ORDER BY time DESC LIMIT 10`,params);const text=rows.map(x=>`\`${x.command}\` **${x.admin}** → ${x.player}\n${x.str} • <t:${x.time}:R>`).join('\n\n')||'Tidak ada log.';return interaction.reply({embeds:[embed('Admin Command Logs',text)],flags:hidden});
    }
    if(interaction.commandName==='admin-paylogs'){
      if(!(await requireAdmin(interaction)))return;const q=interaction.options.getString('player'),threshold=Number(process.env.RTM_ALERT_AMOUNT||1000000),params=[];let where='';if(q){where='WHERE player=? OR toplayer=?';params.push(q,q);}
      const [rows]=await db.execute(`SELECT player,toplayer,ammount,time FROM logpay ${where} ORDER BY time DESC LIMIT 10`,params);const text=rows.map(x=>`${x.ammount>=threshold?'🚩':'•'} **${x.player}** → **${x.toplayer}**\n${rupiah(x.ammount)} • <t:${x.time}:R>`).join('\n\n')||'Tidak ada transaksi.';return interaction.reply({embeds:[embed('Payment Abuse Monitor',text+'\n\n*Flag adalah indikator review, bukan vonis RTM.*')],flags:hidden});
    }
    if(interaction.commandName==='admin-request-cs'){
      if(!(await requireAdmin(interaction)))return;const name=interaction.options.getString('character',true),action=interaction.options.getString('aksi',true);const [rows]=await db.execute('SELECT name FROM requestcs WHERE name=? LIMIT 1',[name]);if(!rows.length)return interaction.reply({content:'Request CS tidak ditemukan.',flags:hidden});if(action==='approve')await db.execute('UPDATE players SET charstory=1 WHERE username=?',[name]);await db.execute('DELETE FROM requestcs WHERE name=?',[name]);return interaction.reply({embeds:[embed('Request CS Diproses',`**${name}** telah **${action}**.`)],flags:hidden});
    }
    if (interaction.commandName === 'admin-stats') {
      if (!(await requireAdmin(interaction))) return;
      const [[stats]] = await db.query(`SELECT (SELECT COUNT(*) FROM ucp) ucp, (SELECT COUNT(*) FROM ucp WHERE verifystatus=0) pending,
        (SELECT COUNT(*) FROM players) players, (SELECT COUNT(*) FROM players WHERE admin>0) admins,
        (SELECT COUNT(*) FROM vehicle) vehicles, (SELECT COUNT(*) FROM houses WHERE owner!='-') owned_houses,
        (SELECT COUNT(*) FROM bisnis WHERE owner!='-') owned_businesses`);
      return interaction.reply({ embeds:[embed('Admin • Database Overview').addFields(Object.entries(stats).map(([k,v])=>({name:k.replaceAll('_',' ').toUpperCase(),value:String(v),inline:true})))], flags:hidden });
    }
    if (interaction.commandName === 'admin-ucp') {
      if (!(await requireAdmin(interaction))) return;
      const username=interaction.options.getString('username',true), action=interaction.options.getString('aksi',true);
      const [rows]=await db.execute('SELECT id, username, admin, verifystatus, discordid, registerdate FROM ucp WHERE username = ? LIMIT 1',[username]);
      if(!rows[0]) return interaction.reply({content:'UCP tidak ditemukan.',flags:hidden});
      if(action!=='info') await db.execute('UPDATE ucp SET verifystatus = ? WHERE id = ?',[action==='verify'?1:0,rows[0].id]);
      const u=rows[0], status=action==='verify'?1:action==='unverify'?0:Number(u.verifystatus);
      return interaction.reply({embeds:[embed(`Admin • UCP ${u.username}`).addFields(
        {name:'ID',value:String(u.id),inline:true},{name:'Status',value:status?'Terverifikasi':'Belum verifikasi',inline:true},{name:'Admin',value:String(u.admin),inline:true},{name:'Discord ID',value:`\`${u.discordid||'-'}\``},{name:'Terdaftar',value:String(u.registerdate||'-')}
      )],flags:hidden});
    }
    if (interaction.commandName === 'admin-player') {
      if (!(await requireAdmin(interaction))) return;
      const name=interaction.options.getString('nama',true);
      const [rows]=await db.execute('SELECT reg_id, username, ucp, level, admin, helper, faction, factionrank, family, familyrank, money, bmoney, hours, warn, jail, last_login FROM players WHERE username = ? LIMIT 1',[name]);
      if(!rows[0]) return interaction.reply({content:'Character tidak ditemukan.',flags:hidden});
      const p=rows[0];
      return interaction.reply({embeds:[embed(`Admin • ${p.username}`).addFields(
        {name:'Reg ID / UCP',value:`${p.reg_id} / ${p.ucp}`,inline:false},{name:'Level',value:String(p.level),inline:true},{name:'Admin / Helper',value:`${p.admin} / ${p.helper}`,inline:true},{name:'Faction',value:`${p.faction} (Rank ${p.factionrank})`,inline:true},{name:'Family',value:`${p.family} (Rank ${p.familyrank})`,inline:true},{name:'Uang + Bank',value:rupiah(p.money+p.bmoney),inline:true},{name:'Jam',value:String(p.hours),inline:true},{name:'Warn / Jail',value:`${p.warn} / ${p.jail?'Ya':'Tidak'}`,inline:true},{name:'Login terakhir',value:String(p.last_login||'-')}
      )],flags:hidden});
    }
    if (interaction.commandName === 'admin-cari') {
      if (!(await requireAdmin(interaction))) return;
      const q=interaction.options.getString('query',true), like=`%${q}%`;
      const [rows]=await db.execute(`SELECT u.id, u.username, u.discordid, u.verifystatus, u.admin,
        COUNT(p.reg_id) characters, COALESCE(MAX(p.admin),0) game_admin
        FROM ucp u LEFT JOIN players p ON p.ucp=u.username
        WHERE u.username LIKE ? OR u.discordid LIKE ? OR p.username LIKE ?
        GROUP BY u.id,u.username,u.discordid,u.verifystatus,u.admin ORDER BY u.id DESC LIMIT 10`,[like,like,like]);
      if(!rows.length) return interaction.reply({content:'Tidak ada UCP atau character yang cocok.',flags:hidden});
      const text=rows.map(u=>`**${u.username}** (#${u.id}) • ${u.verifystatus?'Verified':'Pending'}\nDiscord \`${u.discordid||'-'}\` • ${u.characters} character • Admin ${Math.max(Number(u.admin),Number(u.game_admin))}`).join('\n\n');
      return interaction.reply({embeds:[embed(`Admin • Hasil Pencarian “${q}”`,text)],flags:hidden});
    }
    if (interaction.commandName === 'admin-discord') {
      if (!(await requireAdmin(interaction))) return;
      const username=interaction.options.getString('username',true), user=interaction.options.getUser('discord',true);
      const [used]=await db.execute('SELECT username FROM ucp WHERE discordid=? AND username!=? LIMIT 1',[user.id,username]);
      if(used.length) return interaction.reply({content:`❌ Discord tersebut sudah digunakan UCP **${used[0].username}**.`,flags:hidden});
      const code=`HP-${crypto.randomInt(100000,999999)}`;
      const [result]=await db.execute('UPDATE ucp SET discordid=?, verifystatus=0, verifycode=? WHERE username=?',[user.id,code,username]);
      if(!result.affectedRows) return interaction.reply({content:'UCP tidak ditemukan.',flags:hidden});
      return interaction.reply({embeds:[embed('Discord ID Diperbarui',`UCP **${username}** sekarang terhubung ke ${user}.\nKode verifikasi baru: \`${code}\`\nGunakan \`/verify ${code}\` dari akun Discord tersebut.`)],flags:hidden});
    }
    if (interaction.commandName === 'admin-reset-verifikasi') {
      if (!(await requireAdmin(interaction))) return;
      const username=interaction.options.getString('username',true), code=`HP-${crypto.randomInt(100000,999999)}`;
      const [result]=await db.execute('UPDATE ucp SET verifystatus=0, verifycode=? WHERE username=?',[code,username]);
      if(!result.affectedRows) return interaction.reply({content:'UCP tidak ditemukan.',flags:hidden});
      return interaction.reply({embeds:[embed('Verifikasi UCP Direset',`UCP **${username}** kini belum terverifikasi.\nKode baru: \`${code}\``)],flags:hidden});
    }
    if(interaction.commandName==='admin-add-bisnis'){
      if(!(await requireAdmin(interaction)))return;
      const name=interaction.options.getString('nama',true),type=interaction.options.getInteger('jenis',true),price=interaction.options.getInteger('harga',true);
      const x=interaction.options.getNumber('x')||0,y=interaction.options.getNumber('y')||0,z=interaction.options.getNumber('z')||0;
      await db.execute(`INSERT INTO bisnis (ID,name,type,price,extposx,extposy,extposz,owner,locked,prod) SELECT COALESCE(MAX(ID),-1)+1,?,?,?,?,?,?,'-',1,50 FROM bisnis`,[name,type,price,x,y,z]);
      const [[b]]=await db.query('SELECT ID,name FROM bisnis ORDER BY ID DESC LIMIT 1');
      return interaction.reply({embeds:[embed('Bisnis Ditambahkan',`**${b.name}** berhasil dibuat sebagai Business #${b.ID}.`)],flags:hidden});
    }
    if(interaction.commandName==='admin-voucher'){
      if(!(await requireAdmin(interaction)))return;
      const code=interaction.options.getString('kode',true).toUpperCase(),gold=interaction.options.getInteger('gold')||0,vip=interaction.options.getInteger('vip')||0,days=interaction.options.getInteger('hari')||30;
      if(!/^[A-Z0-9_-]{4,32}$/.test(code))return interaction.reply({content:'Kode voucher tidak valid.',flags:hidden});
      const [used]=await db.execute('SELECT id FROM vouchers WHERE code=? LIMIT 1',[code]);if(used.length)return interaction.reply({content:'Kode voucher sudah digunakan.',flags:hidden});
      const now=Math.floor(Date.now()/1000);await db.execute(`INSERT INTO vouchers (id,code,vip,vip_time,gold,admin,expired) SELECT COALESCE(MAX(id),0)+1,?,?,?,?,?,? FROM vouchers`,[code,vip,vip?now+days*86400:0,gold,interaction.user.username.slice(0,16),now+days*86400]);
      return interaction.reply({embeds:[embed('Voucher Diterbitkan',`Kode \`${code}\` • Gold ${gold} • VIP ${vip} • ${days} hari`)],flags:hidden});
    }
  } catch (error) {
    console.error(`[BOT] /${interaction.commandName}:`, error);
    const payload={content:'⚠️ Terjadi kesalahan saat membaca database. Coba lagi atau hubungi developer.',flags:hidden};
    if(interaction.replied||interaction.deferred) await interaction.followUp(payload).catch(()=>{}); else await interaction.reply(payload).catch(()=>{});
  }
});

client.on('error', error => console.error('[BOT] Discord error:', error));
process.on('SIGINT', async () => { client.destroy(); await db.end(); process.exit(0); });
process.on('SIGTERM', async () => { client.destroy(); await db.end(); process.exit(0); });
client.login(process.env.DISCORD_TOKEN).catch(error => { console.error('[BOT] Login gagal. Pastikan token baru benar:', error.message); process.exit(1); });
