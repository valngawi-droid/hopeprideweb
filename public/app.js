'use strict';

const $ = (s, root = document) => root.querySelector(s);
const $$ = (s, root = document) => [...root.querySelectorAll(s)];
const money = value => new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR', maximumFractionDigits: 0 }).format(Number(value || 0));
const safe = value => String(value ?? '').replace(/[&<>'"]/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;',"'":'&#39;','"':'&quot;'}[c]));
let dashboardData = null;
let demoMode = false;

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
  try { const form = new FormData(e.currentTarget); await api('/api/auth/login', { method:'POST', body:JSON.stringify(Object.fromEntries(form)) }); dashboardData = await api('/api/me'); demoMode = false; showDashboard(); closeAuth(); }
  catch (err) { message(err.message); } finally { button.disabled = false; button.innerHTML = 'Masuk ke UCP <span>→</span>'; }
});
$('#register-form').addEventListener('submit', async e => {
  e.preventDefault(); const button = $('button[type=submit]', e.currentTarget); button.disabled = true; button.textContent = 'Membuat akun...';
  try { const form = new FormData(e.currentTarget); const result = await api('/api/auth/register', { method:'POST', body:JSON.stringify(Object.fromEntries(form)) }); message(`${result.message} Kode: ${result.verifyCode}`, true); e.currentTarget.reset(); }
  catch (err) { message(err.message); } finally { button.disabled = false; button.innerHTML = 'Buat Akun UCP <span>→</span>'; }
});
$('#demo-login').addEventListener('click', async () => { dashboardData = await api('/api/demo'); demoMode = true; showDashboard(); closeAuth(); toast('Mode demo UCP aktif'); });

$$('[data-copy]').forEach(b => b.addEventListener('click', async () => { try { await navigator.clipboard.writeText(b.dataset.copy); } catch {} b.textContent = 'TERSALIN ✓'; toast('IP server disalin'); setTimeout(() => b.textContent = 'SALIN IP', 1800); }));
$('#play-trailer').addEventListener('click', () => toast('Trailer Hope Pride segera hadir.'));

function showDashboard() {
  $('#public-site').classList.add('hidden'); $('footer').classList.add('hidden'); $('.nav').classList.add('hidden'); $('#dashboard').classList.remove('hidden');
  const u = dashboardData.ucp; $('#account-name').textContent = u.username; $('#avatar-letter').textContent = u.username[0].toUpperCase();
  renderView('overview'); window.scrollTo(0,0);
}
function showSite() { $('#dashboard').classList.add('hidden'); $('#public-site').classList.remove('hidden'); $('footer').classList.remove('hidden'); $('.nav').classList.remove('hidden'); window.scrollTo(0,0); }
$('#back-site').addEventListener('click', showSite);
$('#logout').addEventListener('click', async () => { if (!demoMode) await api('/api/auth/logout', {method:'POST'}).catch(()=>{}); dashboardData = null; showSite(); toast('Kamu telah keluar dari UCP'); });
$('#dash-nav').addEventListener('click', e => { const b = e.target.closest('[data-view]'); if (!b) return; $$('#dash-nav button').forEach(x => x.classList.remove('active')); b.classList.add('active'); renderView(b.dataset.view); });

const titleMap = { overview:'Ringkasan Akun', characters:'Character IC', vehicles:'Kendaraan', properties:'Properti', inventory:'Inventori', salary:'Riwayat Gaji' };
function renderView(view) {
  $('#view-title').textContent = titleMap[view]; const el = $('#dash-content');
  if (view === 'overview') return renderOverview(el);
  if (view === 'characters') return renderCharacters(el);
  if (view === 'vehicles') return renderAssets(el, 'vehicles');
  if (view === 'properties') return renderAssets(el, 'properties');
  if (view === 'inventory') return renderInventory(el);
  if (view === 'salary') return renderSalary(el);
}
function charRow(c) { return `<div class="character-row"><div class="char-avatar">${safe(c.name.split('_').map(x=>x[0]).join('').slice(0,2))}</div><div class="row-main"><b>${safe(c.name.replace('_',' '))}</b><small>Level ${c.level} • ${c.hours} jam bermain • ${safe(c.faction)}</small></div><div class="row-value"><b>${money(c.money + c.bank)}</b><small>Total kekayaan</small></div></div>`; }
function renderOverview(el) {
  const d=dashboardData, chars=d.characters, primary=chars[0];
  el.innerHTML=`<div class="welcome"><div><h1>Selamat datang, <em>${safe(d.ucp.username)}.</em></h1><p>${demoMode?'Kamu sedang melihat data demonstrasi.':'Seluruh data tersinkron langsung dengan server game.'}</p></div><span class="verified-badge">✓ &nbsp; UCP TERVERIFIKASI${demoMode?' — DEMO':''}</span></div>
  <div class="metrics"><div class="metric"><small>CHARACTER IC</small><b>${chars.length}</b></div><div class="metric"><small>KENDARAAN</small><b>${d.vehicles.length}</b></div><div class="metric"><small>PROPERTI</small><b>${d.properties.length}</b></div><div class="metric"><small>TOTAL ASET</small><b>${money(chars.reduce((a,c)=>a+Number(c.money)+Number(c.bank),0))}</b></div></div>
  <div class="panel-grid"><div class="panel"><div class="panel-head"><h3>CHARACTER MILIKMU</h3><button data-jump="characters">LIHAT SEMUA →</button></div>${chars.length?chars.map(charRow).join(''):'<div class="empty">Belum ada character IC.</div>'}</div>
  <div class="panel"><div class="panel-head"><h3>KONDISI CHARACTER UTAMA</h3><span></span></div>${primary?`<div class="status-bars">${bar('Health',primary.health)}${bar('Armour',primary.armour)}${bar('Hunger',primary.hunger)}${bar('Energy',primary.energy)}</div>`:'<div class="empty">Tidak ada data.</div>'}</div></div>`;
  $$('[data-jump]',el).forEach(b=>b.addEventListener('click',()=>{const target=$(`[data-view="${b.dataset.jump}"]`);target.click()}));
}
function bar(name,val){const n=Math.max(0,Math.min(100,Number(val)));return `<div><div class="status-label"><span>${name}</span><b>${n}%</b></div><div class="bar"><i style="width:${n}%"></i></div></div>`}
function renderCharacters(el){const c=dashboardData.characters;el.innerHTML=`<div class="welcome"><div><h1>Character <em>In-Character.</em></h1><p>Profil dan perkembangan seluruh character yang terhubung ke UCP.</p></div></div><div class="data-grid">${c.map(x=>`<article class="data-card"><span class="symbol">♙</span><h3>${safe(x.name.replace('_',' '))}</h3><p>Level ${x.level} • ${x.hours} jam • ${safe(x.job)}</p><div class="price">${safe(x.faction)} — Rank ${x.factionRank}</div><p>Terakhir masuk: ${safe(x.lastLogin)}</p></article>`).join('')||'<div class="empty">Belum ada character.</div>'}</div>`}
function renderAssets(el,type){const isVeh=type==='vehicles',items=dashboardData[type];el.innerHTML=`<div class="welcome"><div><h1>${isVeh?'Garasi':'Daftar'} <em>${isVeh?'Kendaraan':'Properti'}.</em></h1><p>Data kepemilikan tersinkron dengan database server.</p></div></div><div class="data-grid">${items.map(x=>isVeh?`<article class="data-card"><span class="symbol">◇</span><h3>${safe(x.name)}</h3><p>${safe(x.owner)} • Model ${x.model} • ID #${x.id}</p><div class="price">Plat ${safe(x.plate||'-')}</div><p>Fuel ${Math.round(x.fuel)}% • ${x.locked?'Terkunci':'Terbuka'}</p></article>`:`<article class="data-card"><span class="symbol">⌂</span><h3>${safe(x.address)}</h3><p>${safe(x.owner)} • Property #${x.id}</p><div class="price">${money(x.price)}</div><p>${x.locked?'Terkunci':'Terbuka'}</p></article>`).join('')||`<div class="empty">Belum ada ${isVeh?'kendaraan':'properti'}.</div>`}</div>`}
function renderInventory(el){const items=dashboardData.inventory;el.innerHTML=`<div class="welcome"><div><h1>Inventori <em>Character.</em></h1><p>Ringkasan item dari seluruh character dalam satu akun.</p></div></div><div class="panel"><div class="panel-head"><h3>SEMUA ITEM</h3><span></span></div>${items.map(x=>`<div class="inventory-row"><div class="char-avatar">▦</div><div class="row-main"><b>${safe(x.item)}</b><small>Item tersimpan</small></div><div class="row-value"><b>× ${x.quantity}</b><small>Jumlah</small></div></div>`).join('')||'<div class="empty">Inventori kosong.</div>'}</div>`}
function renderSalary(el){const rows=dashboardData.salaries;el.innerHTML=`<div class="welcome"><div><h1>Riwayat <em>Gaji.</em></h1><p>Catatan paycheck terbaru milik character.</p></div></div><div class="panel"><div class="panel-head"><h3>TRANSAKSI TERBARU</h3><span></span></div>${rows.map(x=>`<div class="salary-row"><div class="char-avatar">↗</div><div class="row-main"><b>${safe(x.info)}</b><small>${safe(x.date)}</small></div><div class="row-value"><b style="color:var(--green)">+ ${money(x.money)}</b><small>Diterima</small></div></div>`).join('')||'<div class="empty">Belum ada riwayat gaji.</div>'}</div>`}

async function init() {
  const observer=new IntersectionObserver(entries=>entries.forEach(e=>{if(e.isIntersecting)e.target.classList.add('visible')}),{threshold:.08}); $$('.reveal').forEach(e=>observer.observe(e));
  window.addEventListener('scroll',()=>$('.nav').classList.toggle('sticky',window.scrollY>80));
  setInterval(()=>{$('#server-clock').textContent=new Intl.DateTimeFormat('id-ID',{timeZone:'Asia/Jakarta',hour:'2-digit',minute:'2-digit',second:'2-digit',hour12:false}).format(new Date())+' WIB'},1000);
  try { const s=await api('/api/public'); $('#stat-players').textContent=s.players; $('#stat-vehicles').textContent=s.vehicles; $('#stat-properties').textContent=s.properties; $('#stat-ucps').textContent=s.ucps; $('#stat-online').textContent=s.online; } catch {}
  try { const session=await api('/api/session'); if(session.authenticated){dashboardData=await api('/api/me');demoMode=false;$$('.open-auth').forEach(b=>b.textContent='Buka UCP')} } catch {}
}
init();
