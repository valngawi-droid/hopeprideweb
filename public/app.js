'use strict';

const $ = (s, root = document) => root.querySelector(s);
const $$ = (s, root = document) => [...root.querySelectorAll(s)];
const money = value => new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR', maximumFractionDigits: 0 }).format(Number(value || 0));
const safe = value => String(value ?? '').replace(/[&<>'"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]));
let dashboardData = null;

const modal = $('#auth-modal');
function openAuth(tab = 'login') { modal.classList.add('open'); modal.setAttribute('aria-hidden', 'false'); switchAuth(tab); }
function closeAuth() { modal.classList.remove('open'); modal.setAttribute('aria-hidden', 'true'); }
function switchAuth(tab) {
  $$('.auth-tabs button').forEach(b => b.classList.toggle('active', b.dataset.tab === tab));
  $('#login-form').classList.toggle('hidden', tab !== 'login');
  $('#register-form').classList.toggle('hidden', tab !== 'register');
  $('#auth-title').innerHTML = tab === 'login' ? 'SELAMAT DATANG<br><em>KEMBALI.</em>' : 'MULAI KISAH<br><em>BARUMU.</em>';
  $('#auth-desc').textContent = tab === 'login' ? 'Masuk untuk mengelola seluruh kehidupan karaktermu.' : 'Satu akun UCP untuk semua character milikmu.';
  $('#auth-message').innerHTML = '';
}
function toast(text) { const el = $('#toast'); el.textContent = text; el.classList.add('show'); setTimeout(() => el.classList.remove('show'), 2400); }
function message(text, success = false) { $('#auth-message').innerHTML = `<div class="alert ${success ? 'success' : ''}">${safe(text)}</div>`; }
async function api(url, options) {
  const res = await fetch(url, { headers: { 'Content-Type': 'application/json' }, ...options });
  const data = await res.json().catch(() => ({}));
  if (!res.ok) throw new Error(data.error || 'Permintaan gagal. Coba kembali.');
  return data;
}

$$('.open-auth').forEach(b => b.addEventListener('click', () => dashboardData ? showDashboard() : openAuth('login')));
$$('.open-register').forEach(b => b.addEventListener('click', () => openAuth('register')));
$('.modal-close').addEventListener('click', closeAuth);
modal.addEventListener('click', e => { if (e.target === modal) closeAuth(); });
document.addEventListener('keydown', e => { if (e.key === 'Escape') closeAuth(); });
$$('.auth-tabs button').forEach(b => b.addEventListener('click', () => switchAuth(b.dataset.tab)));

$('#login-form').addEventListener('submit', async e => {
  e.preventDefault(); const button = $('button[type=submit]', e.currentTarget); button.disabled = true; button.textContent = 'Memeriksa...';
  try { const form = new FormData(e.currentTarget); await api('/api/auth/login', { method:'POST', body:JSON.stringify(Object.fromEntries(form)) }); dashboardData = await api('/api/me'); showDashboard(); closeAuth(); }
  catch (err) { message(err.message); } finally { button.disabled = false; button.innerHTML = 'Masuk ke UCP <span>→</span>'; }
});
$('#register-form').addEventListener('submit', async e => {
  e.preventDefault(); const button = $('button[type=submit]', e.currentTarget); button.disabled = true; button.textContent = 'Membuat akun...';
  try { const form = new FormData(e.currentTarget); const result = await api('/api/auth/register', { method:'POST', body:JSON.stringify(Object.fromEntries(form)) }); message(`${result.message} Kode: ${result.verifyCode}`, true); e.currentTarget.reset(); }
  catch (err) { message(err.message); } finally { button.disabled = false; button.innerHTML = 'Buat Akun UCP <span>→</span>'; }
});

$$('[data-copy]').forEach(b => b.addEventListener('click', async () => { try { await navigator.clipboard.writeText(b.dataset.copy); } catch {} b.textContent = 'TERSALIN ✓'; toast('IP server disalin'); setTimeout(() => b.textContent = 'SALIN IP', 1800); }));
$('#play-trailer').addEventListener('click', () => toast('Trailer Hope Pride segera hadir.'));

function showDashboard() {
  $('#public-site').classList.add('hidden'); $('footer').classList.add('hidden'); $('.nav').classList.add('hidden'); $('#dashboard').classList.remove('hidden');
  const u = dashboardData.ucp; $('#account-name').textContent = u.username; $('#avatar-letter').textContent = u.username[0].toUpperCase();
  $('#admin-nav').classList.toggle('hidden', !u.isAdmin && Number(u.admin || 0) < 1);
  renderView('overview'); window.scrollTo(0,0);
}
function showSite() { $('#dashboard').classList.add('hidden'); $('#public-site').classList.remove('hidden'); $('footer').classList.remove('hidden'); $('.nav').classList.remove('hidden'); window.scrollTo(0,0); }
$('#back-site').addEventListener('click', showSite);
$('#logout').addEventListener('click', async () => { await api('/api/auth/logout', {method:'POST'}).catch(()=>{}); dashboardData = null; showSite(); toast('Kamu telah keluar dari UCP'); });
$('#dash-nav').addEventListener('click', e => { const b = e.target.closest('[data-view]'); if (!b) return; $$('#dash-nav button').forEach(x => x.classList.remove('active')); b.classList.add('active'); renderView(b.dataset.view); });

const titleMap = { overview:'Ringkasan Akun', characters:'Character IC', vehicles:'Kendaraan', properties:'Properti', inventory:'Inventori', businesses:'Bisnis', salary:'Riwayat Gaji', progress:'Skill & Koleksi', settings:'Pengaturan UCP', admin:'Admin Panel' };
function renderView(view) {
  $('#view-title').textContent = titleMap[view]; const el = $('#dash-content');
  if (view === 'overview') return renderOverview(el);
  if (view === 'characters') return renderCharacters(el);
  if (view === 'vehicles') return renderAssets(el, 'vehicles');
  if (view === 'properties') return renderAssets(el, 'properties');
  if (view === 'businesses') return renderBusinesses(el);
  if (view === 'inventory') return renderInventory(el);
  if (view === 'salary') return renderSalary(el);
  if (view === 'progress') return renderProgress(el);
  if (view === 'settings') return renderSettings(el);
  if (view === 'admin') return renderAdmin(el);
}
function charRow(c) { return `<div class="character-row"><div class="char-avatar">${safe(c.name.split('_').map(x=>x[0]).join('').slice(0,2))}</div><div class="row-main"><b>${safe(c.name.replace('_',' '))}</b><small>Level ${c.level} • ${c.hours} jam bermain • ${safe(c.faction)}</small></div><div class="row-value"><b>${money(c.money + c.bank)}</b><small>Total kekayaan</small></div></div>`; }
function renderOverview(el) {
  const d=dashboardData, chars=d.characters, primary=chars[0];
  el.innerHTML=`<div class="welcome"><div><h1>Selamat datang, <em>${safe(d.ucp.username)}.</em></h1><p>Seluruh data tersinkron langsung dengan server game.</p></div><span class="verified-badge">✓ &nbsp; UCP TERVERIFIKASI</span></div>
  <div class="metrics"><div class="metric"><small>CHARACTER IC</small><b>${chars.length}</b></div><div class="metric"><small>KENDARAAN</small><b>${d.vehicles.length}</b></div><div class="metric"><small>PROPERTI / BISNIS</small><b>${d.properties.length} / ${d.businesses.length}</b></div><div class="metric"><small>TOTAL ASET</small><b>${money(chars.reduce((a,c)=>a+Number(c.money)+Number(c.bank),0))}</b></div></div>
  <div class="panel-grid"><div class="panel"><div class="panel-head"><h3>CHARACTER MILIKMU</h3><button data-jump="characters">LIHAT SEMUA →</button></div>${chars.length?chars.map(charRow).join(''):'<div class="empty">Belum ada character IC.</div>'}</div>
  <div class="panel"><div class="panel-head"><h3>KONDISI CHARACTER UTAMA</h3><span></span></div>${primary?`<div class="status-bars">${bar('Health',primary.health)}${bar('Armour',primary.armour)}${bar('Hunger',primary.hunger)}${bar('Energy',primary.energy)}</div>`:'<div class="empty">Tidak ada data.</div>'}</div></div>`;
  $$('[data-jump]',el).forEach(b=>b.addEventListener('click',()=>{const target=$(`[data-view="${b.dataset.jump}"]`);target.click()}));
}
function bar(name,val){const n=Math.max(0,Math.min(100,Number(val)));return `<div><div class="status-label"><span>${name}</span><b>${n}%</b></div><div class="bar"><i style="width:${n}%"></i></div></div>`}
function renderCharacters(el){const c=dashboardData.characters;el.innerHTML=`<div class="welcome"><div><h1>Character <em>In-Character.</em></h1><p>Profil dan perkembangan seluruh character yang terhubung ke UCP.</p></div></div><div class="data-grid">${c.map(x=>`<article class="data-card"><span class="symbol">♙</span><h3>${safe(x.name.replace('_',' '))}</h3><p>Level ${x.level} • ${x.hours} jam • ${safe(x.job)}</p><div class="price">${safe(x.faction)} — Rank ${x.factionRank}</div><p>Terakhir masuk: ${safe(x.lastLogin)}</p></article>`).join('')||'<div class="empty">Belum ada character.</div>'}</div>`}
function renderAssets(el,type){const isVeh=type==='vehicles',items=dashboardData[type];el.innerHTML=`<div class="welcome"><div><h1>${isVeh?'Garasi':'Daftar'} <em>${isVeh?'Kendaraan':'Properti'}.</em></h1><p>Data kepemilikan tersinkron dengan database server.</p></div></div><div class="data-grid">${items.map(x=>isVeh?`<article class="data-card"><span class="symbol">◇</span><h3>${safe(x.name)}</h3><p>${safe(x.owner)} • Model ${x.model} • ID #${x.id}</p><div class="price">Plat ${safe(x.plate||'-')}</div><p>Fuel ${Math.round(x.fuel)}% • ${x.locked?'Terkunci':'Terbuka'}</p></article>`:`<article class="data-card"><span class="symbol">⌂</span><h3>${safe(x.address)}</h3><p>${safe(x.owner)} • Property #${x.id}</p><div class="price">${money(x.price)}</div><p>${x.locked?'Terkunci':'Terbuka'}</p></article>`).join('')||`<div class="empty">Belum ada ${isVeh?'kendaraan':'properti'}.</div>`}</div>`}
function renderBusinesses(el){const items=dashboardData.businesses||[];el.innerHTML=`<div class="welcome"><div><h1>Bisnis <em>Milikmu.</em></h1><p>Kelola informasi warung, toko umum, toko pakaian, dan usaha lainnya.</p></div></div><div class="data-grid">${items.map(x=>`<article class="data-card business-owned"><span class="symbol">${x.type===1?'☕':x.type===3?'♙':'▦'}</span><h3>${safe(x.name)}</h3><p>${safe(x.typeName)} • Business #${x.id}</p><div class="price">Saldo ${money(x.money)}</div><p>Produk ${x.prod} • ${x.locked?'Tutup / Terkunci':'Buka'} • Restock ${x.restock?'Aktif':'Normal'}</p></article>`).join('')||'<div class="empty">Belum memiliki bisnis.</div>'}</div>`}
function renderInventory(el){const items=dashboardData.inventory;el.innerHTML=`<div class="welcome"><div><h1>Inventori <em>Character.</em></h1><p>Ringkasan item dari seluruh character dalam satu akun.</p></div></div><div class="panel"><div class="panel-head"><h3>SEMUA ITEM</h3><span></span></div>${items.map(x=>`<div class="inventory-row"><div class="char-avatar">▦</div><div class="row-main"><b>${safe(x.item)}</b><small>Item tersimpan</small></div><div class="row-value"><b>× ${x.quantity}</b><small>Jumlah</small></div></div>`).join('')||'<div class="empty">Inventori kosong.</div>'}</div>`}
function renderSalary(el){const rows=dashboardData.salaries;el.innerHTML=`<div class="welcome"><div><h1>Riwayat <em>Gaji.</em></h1><p>Catatan paycheck terbaru milik character.</p></div></div><div class="panel"><div class="panel-head"><h3>TRANSAKSI TERBARU</h3><span></span></div>${rows.map(x=>`<div class="salary-row"><div class="char-avatar">↗</div><div class="row-main"><b>${safe(x.info)}</b><small>${safe(x.date)}</small></div><div class="row-value"><b style="color:var(--green)">+ ${money(x.money)}</b><small>Diterima</small></div></div>`).join('')||'<div class="empty">Belum ada riwayat gaji.</div>'}</div>`}

function renderProgress(el){const skills=dashboardData.skills||[],fish=dashboardData.fish||[];el.innerHTML=`<div class="welcome"><div><h1>Skill & <em>Koleksi.</em></h1><p>Progress kemampuan dan hasil memancing seluruh Character IC.</p></div></div><div class="panel-grid"><div class="panel"><div class="panel-head"><h3>PLAYER SKILLS</h3><span>${skills.length} skill</span></div>${skills.map(s=>`<div class="inventory-row"><div class="char-avatar">★</div><div class="row-main"><b>${safe(s.name)}</b><small>Character ID #${s.owner} • EXP ${s.exp}</small></div><div class="row-value"><b>Level ${s.level}</b><small>Progress</small></div></div>`).join('')||'<div class="empty">Belum ada data skill.</div>'}</div><div class="panel"><div class="panel-head"><h3>FISH COLLECTION</h3><span>${fish.length} tangkapan</span></div>${fish.map(f=>`<div class="inventory-row"><div class="char-avatar">≈</div><div class="row-main"><b>${safe(f.name)}</b><small>Character ID #${f.owner}</small></div><div class="row-value"><b>${Number(f.weight).toLocaleString('id-ID')} gram</b><small>Berat</small></div></div>`).join('')||'<div class="empty">Belum ada koleksi ikan.</div>'}</div></div>`}
function renderSettings(el) {
  const u=dashboardData.ucp;
  el.innerHTML=`<div class="welcome"><div><h1>Pengaturan <em>UCP.</em></h1><p>Kelola keamanan akun dan koneksi Discord.</p></div></div><div class="panel-grid">
  <div class="panel"><div class="panel-head"><h3>GANTI PASSWORD</h3></div><form id="password-form"><label>PASSWORD SAAT INI<input name="currentPassword" type="password" autocomplete="current-password" required></label><label>PASSWORD BARU<input name="newPassword" type="password" minlength="8" maxlength="72" autocomplete="new-password" required></label><button class="btn btn-primary" type="submit">Simpan Password</button></form></div>
  <div class="panel"><div class="panel-head"><h3>DISCORD USER ID</h3></div><p class="settings-note">ID saat ini: <code>${safe(u.discordId||'-')}</code>. Mengganti ID akan membatalkan verifikasi dan menghasilkan kode baru.</p><form id="discord-form"><label>DISCORD ID BARU<input name="discordId" inputmode="numeric" minlength="17" maxlength="20" required></label><label>PASSWORD UCP<input name="currentPassword" type="password" autocomplete="current-password" required></label><button class="btn btn-primary" type="submit">Ganti Discord ID</button></form></div></div><div id="settings-message"></div>`;
  $('#password-form',el).addEventListener('submit',async e=>{e.preventDefault();const b=$('button',e.currentTarget);b.disabled=true;try{const result=await api('/api/me/password',{method:'PATCH',body:JSON.stringify(Object.fromEntries(new FormData(e.currentTarget)))});$('#settings-message').innerHTML=`<div class="alert success">${safe(result.message)}</div>`;e.currentTarget.reset()}catch(error){$('#settings-message').innerHTML=`<div class="alert">${safe(error.message)}</div>`}finally{b.disabled=false}});
  $('#discord-form',el).addEventListener('submit',async e=>{e.preventDefault();const b=$('button',e.currentTarget);b.disabled=true;try{const result=await api('/api/me/discord',{method:'PATCH',body:JSON.stringify(Object.fromEntries(new FormData(e.currentTarget)))});$('#settings-message').innerHTML=`<div class="alert success">${safe(result.message)} Kode: <b>${safe(result.verifyCode)}</b></div>`;dashboardData.ucp.discordId=new FormData(e.currentTarget).get('discordId');dashboardData.ucp.verified=false;e.currentTarget.reset()}catch(error){$('#settings-message').innerHTML=`<div class="alert">${safe(error.message)}</div>`}finally{b.disabled=false}});
}

async function renderAdmin(el, query = '') {
  el.innerHTML = '<div class="empty">Memuat data administrator...</div>';
  let data,staffData;
  try {
    [data,staffData] = await Promise.all([api('/api/admin/overview'+(query?`?q=${encodeURIComponent(query)}`:'')),api('/api/admin/staff')]);
  } catch (error) { el.innerHTML=`<div class="empty">${safe(error.message)}</div>`; return; }
  const c=data.counts;
  el.innerHTML=`<div class="welcome"><div><h1>Administrator <em>Control.</em></h1><p>Akses level ${data.adminLevel} • Data aman tanpa menampilkan password atau IP pemain.</p></div><span class="verified-badge">⚙ &nbsp; ADMIN ACCESS</span></div>
  <div class="metrics"><div class="metric"><small>UCP / PENDING</small><b>${c.ucps} / ${c.pending}</b></div><div class="metric"><small>CHARACTER / ADMIN</small><b>${c.characters} / ${c.admins}</b></div><div class="metric"><small>KENDARAAN</small><b>${c.vehicles}</b></div><div class="metric"><small>RUMAH / BISNIS</small><b>${c.houses} / ${c.businesses}</b></div></div>
  <div class="admin-top-grid"><div class="panel"><div class="panel-head"><h3>STAFF & ADMIN LIST</h3><span>${staffData.total} anggota</span></div><div class="staff-list">${staffData.staff.map(s=>`<div class="staff-card"><span>${safe(s.username[0])}</span><div><b>${safe(s.username)}</b><small>${s.admin?`Administrator Level ${s.admin}`:`Helper Level ${s.helper}`} • ${safe(s.ucp)}</small></div><i class="${s.verifystatus?'online':''}"></i></div>`).join('')||'<div class="empty">Belum ada staff.</div>'}</div></div><div class="panel backup-panel"><span class="backup-icon">⇩</span><div><small>DATABASE SECURITY</small><h3>Backup Database</h3><p>Unduh snapshot SQL lengkap dengan streaming aman. Maksimal lima backup per jam.</p></div><a class="btn btn-primary full" href="/api/admin/backup" download>Download .SQL</a><small>Password database tidak ditulis ke command line atau file website.</small></div></div>
  <div class="panel"><div class="panel-head"><h3>MANAJEMEN UCP</h3><form id="admin-search" class="inline-search"><input name="q" value="${safe(query)}" placeholder="Cari username / Discord ID"><button class="btn btn-primary" type="submit">Cari</button></form></div>
  <div class="admin-table"><div class="admin-table-head"><span>UCP</span><span>DISCORD ID</span><span>CHARACTER</span><span>STATUS</span><span>AKSI</span></div>${data.accounts.map(u=>`<div class="admin-account"><div><b>${safe(u.username)}</b><small>#${u.id} • Admin ${Math.max(Number(u.admin),Number(u.game_admin))}</small></div><code>${safe(u.discordid||'-')}</code><span>${u.characters}</span><span class="state ${u.verifystatus?'ok':'pending'}">${u.verifystatus?'VERIFIED':'PENDING'}</span><div class="admin-actions"><button class="admin-toggle" data-action="verify" data-id="${u.id}" data-state="${u.verifystatus?1:0}">${u.verifystatus?'Batalkan':'Verifikasi'}</button><button class="admin-toggle" data-action="reset" data-id="${u.id}">Reset</button><button class="admin-toggle" data-action="discord" data-id="${u.id}">Discord ID</button></div></div>`).join('')||'<div class="empty">Tidak ada UCP ditemukan.</div>'}</div></div>
  <div class="admin-create-grid"><form class="panel admin-create" id="create-business"><div class="panel-head"><h3>+ TAMBAH BISNIS</h3></div><label>NAMA<input name="name" maxlength="40" placeholder="Hope Pride Clothing" required></label><div class="form-two"><label>JENIS<select name="type"><option value="1">Warung / Restoran</option><option value="2">Toko Umum</option><option value="3">Toko Pakaian</option><option value="4">Usaha Khusus</option></select></label><label>HARGA<input name="price" type="number" min="0" value="500000" required></label></div><div class="form-three"><label>POS X<input name="x" type="number" step="any" value="0"></label><label>POS Y<input name="y" type="number" step="any" value="0"></label><label>POS Z<input name="z" type="number" step="any" value="0"></label></div><button class="btn btn-primary" type="submit">Tambahkan ke Kota</button></form>
  <form class="panel admin-create" id="create-voucher"><div class="panel-head"><h3>+ BUAT VOUCHER</h3></div><label>KODE<input name="code" maxlength="32" placeholder="HOPE2026" required></label><div class="form-two"><label>VIP LEVEL<input name="vip" type="number" min="0" max="3" value="0"></label><label>DURASI VIP (HARI)<input name="vipDays" type="number" min="0" max="365" value="0"></label></div><div class="form-two"><label>GOLD<input name="gold" type="number" min="0" value="0"></label><label>KEDALUWARSA (HARI)<input name="expiresDays" type="number" min="1" max="365" value="30"></label></div><button class="btn btn-primary" type="submit">Terbitkan Voucher</button></form>
  <form class="panel admin-create" id="create-family"><div class="panel-head"><h3>+ BUAT FAMILY</h3></div><label>NAMA FAMILY<input name="name" maxlength="50" required></label><label>LEADER IC<input name="leader" maxlength="50" placeholder="Nama_Character" required></label><label>MOTD<input name="motd" maxlength="100" placeholder="Welcome to the family"></label><label>WARNA (INTEGER)<input name="color" type="number" value="0"></label><button class="btn btn-primary" type="submit">Buat Family</button></form></div>`;
  $('#admin-search',el).addEventListener('submit',e=>{e.preventDefault();renderAdmin(el,new FormData(e.currentTarget).get('q').trim())});
  [['#create-business','/api/admin/businesses'],['#create-voucher','/api/admin/vouchers'],['#create-family','/api/admin/families']].forEach(([selector,url])=>$(selector,el).addEventListener('submit',async e=>{e.preventDefault();const button=$('button[type=submit]',e.currentTarget),original=button.textContent;button.disabled=true;button.textContent='Menyimpan...';try{const result=await api(url,{method:'POST',body:JSON.stringify(Object.fromEntries(new FormData(e.currentTarget)))});toast(result.code?`Voucher ${result.code} dibuat`:'Data berhasil ditambahkan');e.currentTarget.reset();if(url.includes('businesses'))loadBusinesses()}catch(error){toast(error.message)}finally{button.disabled=false;button.textContent=original}}));
  $$('.admin-toggle',el).forEach(button=>button.addEventListener('click',async()=>{
    button.disabled=true;
    try{
      if(button.dataset.action==='verify'){await api(`/api/admin/ucp/${button.dataset.id}/verification`,{method:'PATCH',body:JSON.stringify({verified:button.dataset.state!=='1'})});toast('Status verifikasi diperbarui')}
      if(button.dataset.action==='reset'){const r=await api(`/api/admin/ucp/${button.dataset.id}/reset-verification`,{method:'POST'});alert(`Kode verifikasi baru: ${r.verifyCode}`)}
      if(button.dataset.action==='discord'){const id=prompt('Masukkan Discord User ID baru (17–20 digit):');if(!id){button.disabled=false;return}const r=await api(`/api/admin/ucp/${button.dataset.id}/discord`,{method:'PATCH',body:JSON.stringify({discordId:id.trim()})});alert(`Discord ID diubah. Kode verifikasi baru: ${r.verifyCode}`)}
      renderAdmin(el,query)
    } catch(error){toast(error.message);button.disabled=false}
  }));
}

let forumCategories=[],forumCategory=0;
async function loadForumCategories(){
  const host=$('#forum-category-list');
  try{const data=await api('/api/forum/categories');forumCategories=data.categories;host.innerHTML=data.categories.map(c=>`<button data-forum-category="${c.id}"><span>${safe(c.icon)}</span><b>${safe(c.name)}</b><small>${c.topics}</small></button>`).join('');$('#topic-category').innerHTML=data.categories.map(c=>`<option value="${c.id}">${safe(c.name)}</option>`).join('');$$('[data-forum-category]',host).forEach(b=>b.addEventListener('click',()=>{$$('[data-forum-category]').forEach(x=>x.classList.remove('active'));b.classList.add('active');forumCategory=Number(b.dataset.forumCategory);loadForumTopics()}));await loadForumTopics()}catch(error){host.innerHTML='';$('#forum-content-list').innerHTML=`<div class="forum-empty">${safe(error.message)}</div>`}
}
async function loadForumTopics(){
  const host=$('#forum-content-list'),q=$('#forum-search-input').value.trim();$('#forum-back').classList.add('hidden');host.innerHTML='<div class="forum-empty">Memuat topic...</div>';
  try{const data=await api(`/api/forum/topics?category=${forumCategory}&q=${encodeURIComponent(q)}`);host.innerHTML=data.topics.length?`<div class="topic-table-head"><span>TOPIC</span><span>REPLIES</span><span>VIEWS</span><span>UPDATED</span></div>`+data.topics.map(t=>`<button class="topic-row" data-topic-id="${t.id}"><span class="topic-symbol">${t.pinned?'◆':t.locked?'⌕':'◯'}</span><span class="topic-title"><b>${safe(t.title)}</b><small>${safe(t.category_name)} • oleh ${safe(t.author_ucp)}</small></span><span>${t.replies}</span><span>${t.views}</span><time>${formatForumDate(t.updated_at)}</time></button>`).join(''):'<div class="forum-empty">Belum ada topic. Jadilah yang pertama berdiskusi.</div>';$$('[data-topic-id]',host).forEach(b=>b.addEventListener('click',()=>openForumTopic(b.dataset.topicId)))}catch(error){host.innerHTML=`<div class="forum-empty">${safe(error.message)}</div>`}
}
function formatForumDate(value){if(!value)return'-';const d=new Date(value);return Number.isNaN(d.getTime())?safe(value):new Intl.DateTimeFormat('id-ID',{day:'2-digit',month:'short',year:'numeric'}).format(d)}
async function openForumTopic(id){
  const host=$('#forum-content-list');host.innerHTML='<div class="forum-empty">Membuka topic...</div>';
  try{const data=await api(`/api/forum/topics/${id}`),t=data.topic,isAdmin=Boolean(dashboardData?.ucp?.isAdmin);$('#forum-back').classList.remove('hidden');host.innerHTML=`<article class="topic-detail"><div class="topic-detail-head"><span>${safe(t.category_name)}</span><h3>${safe(t.title)}</h3><small>Oleh <b>${safe(t.author_ucp)}</b> • ${formatForumDate(t.created_at)} • ${t.views} views</small></div><div class="forum-post original"><div class="post-author"><span>${safe(t.author_ucp[0].toUpperCase())}</span><b>${safe(t.author_ucp)}</b><small>Topic Author</small></div><div class="post-body">${safe(t.content).replace(/\n/g,'<br>')}</div></div>${data.posts.map(p=>`<div class="forum-post"><div class="post-author"><span>${safe(p.author_ucp[0].toUpperCase())}</span><b>${safe(p.author_ucp)}</b><small>${formatForumDate(p.created_at)}</small></div><div class="post-body">${safe(p.content).replace(/\n/g,'<br>')}</div></div>`).join('')}${t.locked&&!isAdmin?'<div class="forum-locked">Topic ini telah dikunci oleh administrator.</div>':`<form class="reply-form" id="reply-form"><textarea name="content" maxlength="5000" placeholder="Tulis balasan..." required></textarea><button class="btn btn-primary" type="submit">Kirim Balasan</button></form>`}${isAdmin?`<div class="moderation-bar"><b>MODERATION</b><button data-moderate="pin">${t.pinned?'Lepas Pin':'Pin Topic'}</button><button data-moderate="lock">${t.locked?'Buka Topic':'Kunci Topic'}</button></div>`:''}</article>`;
    const reply=$('#reply-form',host);if(reply)reply.addEventListener('submit',async e=>{e.preventDefault();if(!dashboardData)return openAuth('login');const b=$('button',e.currentTarget);b.disabled=true;try{await api(`/api/forum/topics/${id}/posts`,{method:'POST',body:JSON.stringify(Object.fromEntries(new FormData(e.currentTarget)))});openForumTopic(id)}catch(error){toast(error.message);b.disabled=false}});
    $$('[data-moderate]',host).forEach(b=>b.addEventListener('click',async()=>{await api(`/api/forum/topics/${id}/moderation`,{method:'PATCH',body:JSON.stringify({pinned:b.dataset.moderate==='pin'?!t.pinned:t.pinned,locked:b.dataset.moderate==='lock'?!t.locked:t.locked})});openForumTopic(id)}));
  }catch(error){host.innerHTML=`<div class="forum-empty">${safe(error.message)}</div>`}
}

let businessType=0, businessTimer;
async function loadBusinesses(){
  const grid=$('#business-grid'); if(!grid)return;
  grid.innerHTML='<div class="directory-loading">Memuat usaha Hope City...</div>';
  const q=$('#business-search').value.trim();
  try{const data=await api(`/api/city/businesses?type=${businessType}&q=${encodeURIComponent(q)}`);const labels=['','Warung & Restoran','Toko Umum','Toko Pakaian','Usaha Khusus'];const icons=['','☕','▦','♙','◇'];grid.innerHTML=data.businesses.length?data.businesses.map((b,i)=>`<article class="business-card" style="--delay:${Math.min(i,12)*45}ms"><div class="business-card-top"><span class="business-icon">${icons[b.type]||'▤'}</span><span class="business-state ${b.locked?'closed':'open'}">${b.locked?'TUTUP':'BUKA'}</span></div><small>${safe(labels[b.type]||`BISNIS ${b.type}`)}</small><h3>${safe(b.name)}</h3><p>${b.owner==='-'?'Milik Pemerintah':`Pemilik • ${safe(b.owner.replace('_',' '))}`}</p><div class="business-meta"><span>Stok <b>${b.prod}</b></span><span>Nilai <b>${money(b.price)}</b></span></div></article>`).join(''):'<div class="directory-loading">Tidak ada bisnis yang cocok.</div>'}catch(error){grid.innerHTML=`<div class="directory-loading offline">${safe(error.message)}</div>`}
}

async function init() {
  const observer=new IntersectionObserver(entries=>entries.forEach(e=>{if(e.isIntersecting)e.target.classList.add('visible')}),{threshold:.08}); $$('.reveal').forEach(e=>observer.observe(e));
  window.addEventListener('scroll',()=>$('.nav').classList.toggle('sticky',window.scrollY>80),{passive:true});
  $('.mobile-menu').addEventListener('click',()=>$('.nav-links').classList.toggle('mobile-open'));
  $$('.nav-links a').forEach(a=>a.addEventListener('click',()=>$('.nav-links').classList.remove('mobile-open')));
  $$('[data-business-type]').forEach(b=>b.addEventListener('click',()=>{$$('[data-business-type]').forEach(x=>x.classList.remove('active'));b.classList.add('active');businessType=Number(b.dataset.businessType);loadBusinesses()}));
  $('#business-search').addEventListener('input',()=>{clearTimeout(businessTimer);businessTimer=setTimeout(loadBusinesses,280)});
  loadBusinesses();
  $('[data-forum-category="0"]').addEventListener('click',e=>{$$('[data-forum-category]').forEach(x=>x.classList.remove('active'));e.currentTarget.classList.add('active');forumCategory=0;loadForumTopics()});
  loadForumCategories();
  $('#forum-search-button').addEventListener('click',loadForumTopics);$('#forum-search-input').addEventListener('keydown',e=>{if(e.key==='Enter')loadForumTopics()});$('#forum-back').addEventListener('click',loadForumTopics);
  $('#new-topic-button').addEventListener('click',()=>{if(!dashboardData)return openAuth('login');$('#forum-compose').classList.remove('hidden')});$('.compose-close').addEventListener('click',()=>$('#forum-compose').classList.add('hidden'));$('#forum-compose').addEventListener('click',e=>{if(e.target===$('#forum-compose'))$('#forum-compose').classList.add('hidden')});
  $('#new-topic-form').addEventListener('submit',async e=>{e.preventDefault();const b=$('button',e.currentTarget);b.disabled=true;try{const result=await api('/api/forum/topics',{method:'POST',body:JSON.stringify(Object.fromEntries(new FormData(e.currentTarget)))});$('#forum-compose').classList.add('hidden');e.currentTarget.reset();await loadForumCategories();openForumTopic(result.id);toast('Topic berhasil dipublikasikan')}catch(error){toast(error.message)}finally{b.disabled=false}});
  setInterval(()=>{$('#server-clock').textContent=new Intl.DateTimeFormat('id-ID',{timeZone:'Asia/Jakarta',hour:'2-digit',minute:'2-digit',second:'2-digit',hour12:false}).format(new Date())+' WIB'},1000);
  try { const s=await api('/api/public'); $('#stat-players').textContent=s.players; $('#stat-vehicles').textContent=s.vehicles; $('#stat-properties').textContent=s.properties; $('#stat-ucps').textContent=s.ucps; $('#stat-online').textContent=s.online; $('#server-status-text').textContent=s.database==='live'?'TERHUBUNG':'DATABASE OFFLINE'; $('#server-status-text').style.color=s.database==='live'?'var(--green)':'#e66f6f'; $('#portal-online').textContent=s.online;$('#portal-characters').textContent=s.players;$('#portal-vehicles').textContent=s.vehicles;$('#portal-properties').textContent=s.properties;$('#forum-businesses').textContent=s.businesses;$('#forum-characters').textContent=s.players;$('#forum-families').textContent=s.families;$('#portal-db-dot').classList.toggle('offline',s.database!=='live');if(s.serverAddress){$('#server-ip').textContent=s.serverAddress;$('#notice-server-ip').textContent=s.serverAddress;$('.copy-btn').dataset.copy=s.serverAddress;$('.notice-copy').dataset.copy=s.serverAddress}else{$('#server-ip').textContent='Belum dikonfigurasi';$('.copy-btn').classList.add('hidden');$('.notice-copy').classList.add('hidden')} if(s.discordInvite){$('#discord-link').href=s.discordInvite}else{$('#discord-link').removeAttribute('href')} } catch { $('#server-status-text').textContent='TIDAK TERSEDIA'; }
  try { const session=await api('/api/session'); if(session.authenticated){dashboardData=await api('/api/me');$$('.open-auth').forEach(b=>b.textContent='Buka UCP')} } catch {}
}
init();
