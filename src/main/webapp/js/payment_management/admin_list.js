/* eslint-disable no-undef */
const API_PAYMENT = '/api/payments';

const loader = document.getElementById('loader');
const tableWrapper = document.getElementById('tableWrapper');
const tbody = document.getElementById('payment-tbody');

const modal = document.getElementById('editModal');
const form  = document.getElementById('editForm');
const cancelBtn = document.getElementById('cancelBtn');
const toast = document.getElementById('toast');
const toastMsg = document.getElementById('toast-msg');

let payments = [];

/* ===== API ===== */
async function fetchJson(url, options = {}) {
    const res = await fetch(url, { ...options, headers: { 'Content-Type': 'application/json', ...options.headers } });
    if (!res.ok) throw new Error((await res.text()) || 'Network error');
    return res.status !== 204 ? await res.json() : null;
}

/* ===== Load ===== */
async function loadPayments() {
    try {
        payments = await fetchJson(API_PAYMENT);
        renderTable(payments);
    } catch (err) {
        showToast('Could not load payments', 'error');
    } finally {
        loader.classList.add('hidden');
        tableWrapper.classList.remove('hidden');
    }
}

/* ===== Render ===== */
function renderTable(list) {
    tbody.innerHTML = '';
    list.forEach(p => tbody.appendChild(renderRow(p)));
}

function renderRow(p) {
    const tr = document.createElement('tr');
    tr.className = 'hover:bg-gray-50';
    tr.innerHTML = `
      <td class="px-4 py-3 font-medium">${p.id}</td>
      <td class="px-4 py-3">${p.amount}</td>
      <td class="px-4 py-3">${p.method}</td>
      <td class="px-4 py-3">
        <span class="px-2 py-1 rounded-full text-xs ${statusColor(p.status)}">${p.status}</span>
      </td>
      <td class="px-4 py-3">${p.paidByName} <span class="text-gray-500">(${p.paidByEmail})</span></td>
      <td class="px-4 py-3">#${p.paidToBookingId} <span class="text-gray-500">(${p.bookingDate})</span></td>
      <td class="px-4 py-3 text-center space-x-2">
        <button onclick="editPayment(${p.id})" class="text-indigo-600 hover:text-indigo-900">
          <i class="fa-solid fa-pen-to-square"></i>
        </button>
        <button onclick="deletePayment(${p.id})" class="text-red-600 hover:text-red-900">
          <i class="fa-solid fa-trash"></i>
        </button>
      </td>`;
    return tr;
}

function statusColor(s) {
    switch (s) {
        case 'COMPLETED': return 'bg-green-100 text-green-700';
        case 'FAILED': return 'bg-red-100 text-red-700';
        case 'REFUNDED': return 'bg-gray-100 text-gray-700';
        default: return 'bg-yellow-100 text-yellow-700';
    }
}

/* ===== Modal ===== */
function openModal() {
    modal.classList.remove('hidden');
    modal.classList.add('flex');
}
function closeModal() {
    modal.classList.add('hidden');
    modal.classList.remove('flex');
    form.reset();
    document.getElementById('paymentId').value = '';
}

/* ===== CRUD ===== */
window.editPayment = id => {
    const p = payments.find(x => x.id === id);
    if (!p) return;
    document.getElementById('paymentId').value = id;
    document.getElementById('amount').value = p.amount;
    document.getElementById('method').value = p.method;
    document.getElementById('status').value = p.status;
    document.getElementById('paidBy').value = p.paidById;
    document.getElementById('paidTo').value = p.paidToBookingId;
    openModal();
};

window.deletePayment = async id => {
    if (!confirm('Are you sure you want to delete this payment?')) return;
    try {
        await fetchJson(`${API_PAYMENT}/${id}`, { method: 'DELETE' });
        showToast('Payment deleted');
        await loadPayments();
    } catch (err) {
        await loadPayments();
    }
};

/* ===== Form submit ===== */
form.addEventListener('submit', async e => {
    e.preventDefault();
    const id = document.getElementById('paymentId').value;
    const payload = {
        deleteStatus: false, // always false for admin update
        status: document.getElementById('status').value,
        amount: parseFloat(document.getElementById('amount').value),
        method: document.getElementById('method').value,
        paidBy: Number(document.getElementById('paidBy').value),
        paidTo: Number(document.getElementById('paidTo').value)
    };
    try {
        if (id) await fetchJson(`${API_PAYMENT}/${id}`, { method: 'PUT', body: JSON.stringify(payload) });
        showToast('Payment updated');
        closeModal();
        await loadPayments();
    } catch (err) {
        showToast('Update failed', 'error');
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
cancelBtn.addEventListener('click', closeModal);
loadPayments();