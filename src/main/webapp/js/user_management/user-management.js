/* eslint-disable no-undef */
const API_USER = '/api/users';

const loader = document.getElementById('loader');
const tableWrapper = document.getElementById('tableWrapper');
const tbody = document.getElementById('guide-tbody');

const modal = document.getElementById('guideModal');
const form = document.getElementById('guideForm');
const modalTitle = document.getElementById('modalTitle');
const cancelBtn = document.getElementById('cancelBtn');
const toast = document.getElementById('toast');
const toastMsg = document.getElementById('toast-msg');

const REGEX = {
    email: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    phone: /^[\+]?[0-9]{7,15}$/
};

let guides = [];

/* ===== API ===== */
async function fetchJson(url, options = {}) {
    const res = await fetch(url, { ...options, headers: { 'Content-Type': 'application/json', ...options.headers } });
    if (!res.ok) throw new Error((await res.text()) || 'Network error');
    return res.status !== 204 ? await res.json() : null;
}

/* ===== Load ===== */
async function loadGuides() {
    try {
        guides = await fetchJson(API_USER);
        guides = guides.filter(g => g.userRole === 'GUIDE');
        renderTable(guides);
    } catch (err) {
        showToast('Could not load guides', 'error');
    } finally {
        loader.classList.add('hidden');
        tableWrapper.classList.remove('hidden');
    }
}

/* ===== Render ===== */
function renderTable(list) {
    tbody.innerHTML = '';
    list.forEach(g => tbody.appendChild(renderRow(g)));
}

function renderRow(g) {
    const tr = document.createElement('tr');
    tr.className = 'hover:bg-gray-50';
    tr.innerHTML = `
      <td class="px-4 py-3 font-medium">${g.id}</td>
      <td class="px-4 py-3">${g.firstName} ${g.lastName}</td>
      <td class="px-4 py-3">${g.email}</td>
      <td class="px-4 py-3">${g.phoneNumber}</td>
      <td class="px-4 py-3">${g.country}</td>
      <td class="px-4 py-3">${g.vehicleType}</td>
      <td class="px-4 py-3">${g.language}</td>
      <td class="px-4 py-3">${g.expertise}</td>
      <td class="px-4 py-3 text-center space-x-2">
        <button onclick="editGuide(${g.id})" class="text-indigo-600 hover:text-indigo-900">
          <i class="fa-solid fa-pen-to-square"></i>
        </button>
        <button onclick="deleteGuide(${g.id})" class="text-red-600 hover:text-red-900">
          <i class="fa-solid fa-trash"></i>
        </button>
      </td>`;
    return tr;
}

/* ===== Modal ===== */
function openModal(isEdit = false) {
    modalTitle.textContent = isEdit ? 'Edit Guide' : 'Add Guide';
    document.getElementById('passwordWrapper').style.display = isEdit ? 'none' : 'block';
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}
function closeModal() {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
    form.reset();
    document.getElementById('guideId').value = '';
}

/* ===== CRUD ===== */
async function createGuide(payload) {
    await fetchJson(API_USER, { method: 'POST', body: JSON.stringify(payload) });
    showToast('Guide created');
    await loadGuides();
}

async function updateGuide(id, payload) {
    await fetchJson(`${API_USER}/${id}`, { method: 'PUT', body: JSON.stringify(payload) });
    showToast('Guide updated');
    await loadGuides();
}

window.editGuide = async id => {
    const g = guides.find(x => x.id === id);
    if (!g) return;
    Object.keys(g).forEach(k => {
        const el = document.getElementById(k);
        if (el) el.value = g[k];
    });
    document.getElementById('guideId').value = g.id;
    openModal(true);
};

window.deleteGuide = async id => {
    if (!confirm('Delete this guide?')) return;
    await fetchJson(`${API_USER}/${id}`, { method: 'DELETE' });
    showToast('Guide deleted');
    await loadGuides();
};

/* ===== Form submit ===== */
form.addEventListener('submit', async e => {
    e.preventDefault();
    if (!REGEX.email.test(document.getElementById('email').value)) {
        showToast('Invalid email format', 'error'); return;
    }
    if (!REGEX.phone.test(document.getElementById('phoneNumber').value)) {
        showToast('Invalid phone format', 'error'); return;
    }
    const payload = {
        firstName: document.getElementById('firstName').value,
        lastName: document.getElementById('lastName').value,
        email: document.getElementById('email').value,
        phoneNumber: document.getElementById('phoneNumber').value,
        country: document.getElementById('country').value,
        vehicleType: document.getElementById('vehicleType').value,
        language: document.getElementById('language').value,
        expertise: document.getElementById('expertise').value,
        userRole: 'GUIDE'
    };
    if (!document.getElementById('guideId').value) payload.password = document.getElementById('password').value;

    try {
        if (document.getElementById('guideId').value) await updateGuide(document.getElementById('guideId').value, payload);
        else await createGuide(payload);
        closeModal();
    } catch (err) {
        showToast('Operation failed', 'error');
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
document.getElementById('openCreateModalBtn').addEventListener('click', () => openModal(false));
cancelBtn.addEventListener('click', closeModal);
loadGuides();