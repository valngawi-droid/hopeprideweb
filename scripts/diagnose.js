'use strict';
require('dotenv').config({ quiet:true });
const mysql=require('mysql2/promise');

(async()=>{
  let failed=false;
  if(!process.env.DB_HOST){console.error('✗ DB_HOST belum diisi di .env');failed=true;}
  else{
    let db;
    try{
      db=await mysql.createConnection({host:process.env.DB_HOST,port:Number(process.env.DB_PORT||3306),user:process.env.DB_USER,password:process.env.DB_PASSWORD,database:process.env.DB_NAME||'hope',charset:'utf8mb4'});
      const required=['ucp','players','vehicle','inventory','familys','requestcs','logstaff','logpay','web_sessions','web_forum_categories','web_forum_topics','web_forum_posts'];
      const [rows]=await db.query(`SELECT table_name FROM information_schema.tables WHERE table_schema=? AND table_name IN (${required.map(()=>'?').join(',')})`,[process.env.DB_NAME||'hope',...required]);
      const found=new Set(rows.map(r=>r.TABLE_NAME||r.table_name));
      for(const table of required){
        if(found.has(table))console.log(`✓ Database table ${table}`);else{console.error(`✗ Tabel ${table} belum ada`);failed=true;}
      }
      console.log('✓ Koneksi MariaDB berhasil');
    }catch(error){console.error(`✗ Koneksi MariaDB gagal: ${error.code||error.message}`);failed=true;}finally{if(db)await db.end();}
  }
  if(process.env.DISCORD_TOKEN){
    try{
      const response=await fetch('https://discord.com/api/v10/users/@me',{headers:{Authorization:`Bot ${process.env.DISCORD_TOKEN}`},signal:AbortSignal.timeout(10000)});
      if(response.ok){const bot=await response.json();console.log(`✓ Discord Bot valid: ${bot.username}#${bot.discriminator||'0'}`);}
      else console.error(`✗ Discord Bot token ditolak (HTTP ${response.status}). Reset token di Developer Portal.`);
    }catch(error){console.error(`! Discord API tidak dapat diperiksa: ${error.message}`);}
  }else console.error('! DISCORD_TOKEN kosong — bot tidak akan dijalankan');
  if(failed)process.exit(1);
})().catch(error=>{console.error(error);process.exit(1)});
