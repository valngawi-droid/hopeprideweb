'use strict';
const session = require('express-session');
const Store = require('express-mysql-session')(session);
const store = new Store({
  host: '127.0.0.1', port: 3306, user: 'contract_test', password: '', database: 'hope',
  createDatabaseTable: false, clearExpired: false,
  schema: { tableName:'web_sessions', columnNames:{session_id:'session_id',expires:'expires',data:'data'} }
});
if (!store.connection || typeof store.connection.query !== 'function') {
  console.error('Session store contract GAGAL: connection.query bukan function');
  process.exitCode = 1;
} else {
  console.log('Session store contract OK — mysql2 pool memiliki connection.query().');
}
store.close().catch(() => {});
