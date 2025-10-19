/* eslint-disable no-undef */
const API_SCHEDULE = '/api/guide-schedules';
const API_BOOKING  = '/api/bookings';
const API_GUIDE    = '/api/users';          // ?role=GUIDE

const tbody   = document.getElementById('schedule-tbody');
const modal   = document.getElementById('scheduleModal');
const form    = document.getElementById('scheduleForm');
const toast   = document.getElementById('toast');
const toastMsg= document.getElementById('toast-msg');

const openBtn  = document.getElementById('openCreateModalBtn');
const cancelBtn= document.getElementById('cancelBtn');
const guideSel = document.getElementById('guideSelect');
const bookSel  = document.getElementById('bookingSelect');
const modalTitle=document.getElementById('modalTitle');

let guides   = [];
let bookings = [];
let schedules= [];

/* ===== API helpers ===== */
async function fetchJson(url, options = {}) {
    const res = await fetch(url, { ...options, headers: { 'Content-Type': 'application/json', ...options.headers } });
    if (!res.ok) throw new Error((await res.text()) || 'Network error');
    return res.status !== 204 ? await res.json() : null;
}

/* ===== Load data ===== */
async function loadGuides() {
    guides = await fetchJson(`${API_GUIDE}?role=GUIDE`);
    guides = guides.filter((guide)=>guide.userRole==='GUIDE')
    guideSel.innerHTML = '<option value="">-- Select Guide --</option>' +
        guides.map(g => `<option value="${g.id}">${g.firstName} ${g.lastName} (${g.email})</option>`).join('');
}

async function loadBookings() {
    bookings = await fetchJson(API_BOOKING);
    bookSel.innerHTML = '<option value="">-- Select Booking --</option>' +
        bookings.map(b => `<option value="${b.id}">#${b.id} - ${b.customerName} (${b.bookingDate})</option>`).join('');
}

async function loadSchedules() {
    schedules = await fetchJson(API_SCHEDULE);
    renderTable(schedules);
}

/* ===== Render ===== */
function renderTable(list) {
    tbody.innerHTML = '';
    list.forEach(s => tbody.appendChild(renderRow(s)));
}

function renderRow(s) {
    const tr = document.createElement('tr');
    tr.className = 'hover:bg-gray-50';
    tr.innerHTML = `
      <td class="px-4 py-3 font-medium">${s.id}</td>
      <td class="px-4 py-3">${s.guideName} <span class="text-gray-500">(${s.guideEmail})</span></td>
      <td class="px-4 py-3">#${s.bookingId}</td>
      <td class="px-4 py-3">${s.bookingDate}</td>
      <td class="px-4 py-3 text-center space-x-2">
        <button onclick="editSchedule(${s.id})" class="text-indigo-600 hover:text-indigo-900">
          <i class="fa-solid fa-pen-to-square"></i>
        </button>
        <button onclick="deleteSchedule(${s.id})" class="text-red-600 hover:text-red-900">
          <i class="fa-solid fa-trash"></i>
        </button>
      </td>`;
    return tr;
}

/* ===== Modal ===== */
function openModal(isEdit = false) {
    modalTitle.textContent = isEdit ? 'Edit Schedule' : 'Create Schedule';
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}

function closeModal() {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
    form.reset();
    document.getElementById('scheduleId').value = '';
}

/* ===== CRUD ===== */
async function createSchedule(payload) {
    await fetchJson(API_SCHEDULE, { method: 'POST', body: JSON.stringify(payload) });
    showToast('Created successfully');
    await loadSchedules();
}

async function updateSchedule(id, payload) {
    await fetchJson(`${API_SCHEDULE}/${id}`, { method: 'PUT', body: JSON.stringify(payload) });
    showToast('Updated successfully');
    await loadSchedules();
}

window.editSchedule = async id => {
    const s = schedules.find(x => x.id === id);
    if (!s) return;
    document.getElementById('scheduleId').value = s.id;
    guideSel.value = s.guideId;
    bookSel.value  = s.bookingId;
    openModal(true);
};

window.deleteSchedule = async id => {
    if (!confirm('Delete this schedule?')) return;
    await fetchJson(`${API_SCHEDULE}/${id}`, { method: 'DELETE' });
    showToast('Deleted successfully');
    await loadSchedules();
};

/* ===== Form handler ===== */
form.addEventListener('submit', async e => {
    e.preventDefault();
    const payload = {
        guideId: Number(guideSel.value),
        bookingId: Number(bookSel.value)
    };
    const id = document.getElementById('scheduleId').value;
    try {
        if (id) await updateSchedule(Number(id), payload);
        else await createSchedule(payload);
        closeModal();
    } catch (err) {
        showToast(err.message, 'error');
    }
});

/* ===== Toast ===== */
function showToast(msg, type = 'success') {
    toastMsg.textContent = msg;
    toast.className = `fixed bottom-5 right-5 flex items-center px-4 py-3 rounded-lg text-white shadow-lg transition
                     ${type === 'success' ? 'bg-green-600' : 'bg-red-600'}`;
    toast.classList.remove('hidden');
    setTimeout(() => toast.classList.add('hidden'), 3000);
}

/* ===== Init ===== */
openBtn.addEventListener('click', () => openModal(false));
cancelBtn.addEventListener('click', closeModal);

(async () => {
    await Promise.all([loadGuides(), loadBookings(), loadSchedules()]);
})();