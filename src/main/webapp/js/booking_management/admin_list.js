/* eslint-disable no-undef */
const API_BASE = '/api/bookings';
const STATUSES = ['PENDING', 'FAILED', 'COMPLETED', 'CANCELLED'];

const tbody = document.getElementById('booking-tbody');
const toast = document.getElementById('toast');
const toastMsg = document.getElementById('toast-msg');
const statusFilter = document.getElementById('statusFilter');

let originalBookings = [];          // untouched from server
let filteredBookings = [];          // after client filter

/* ---------- API ---------- */
async function fetchBookings() {
    try {
        const res = await fetch(API_BASE);
        if (!res.ok) throw new Error('Network error');
        return await res.json();
    } catch (err) {
        showToast('Could not load bookings', 'error');
        return [];
    }
}

async function updateBooking(booking) {
    try {
        const res = await fetch(`${API_BASE}/${booking.id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(booking)          // <-- full object
        });
        if (!res.ok) throw new Error('Update failed');
        showToast('Booking updated', 'success');
    } catch (err) {
        showToast('Update failed', 'error');
        throw err;
    }
}

/* ---------- RENDER ---------- */
function renderTable(list) {
    tbody.innerHTML = '';
    list.forEach(b => tbody.appendChild(renderRow(b)));
}

function renderRow(b) {
    const tr = document.createElement('tr');
    tr.className = 'hover:bg-gray-50';
    tr.innerHTML = `
      <td class="px-4 py-3 font-medium text-gray-900">${b.id}</td>
      <td class="px-4 py-3">${b.bookingDate}</td>
      <td class="px-4 py-3">${b.customerName}</td>
      <td class="px-4 py-3">${b.customerEmail}</td>
      <td class="px-4 py-3 max-w-xs truncate" title="${b.additionalNotes || ''}">${b.additionalNotes || '-'}</td>
      <td class="px-4 py-3">${statusDropdown(b)}</td>
      <td class="px-4 py-3 text-center">
        <button class="text-indigo-600 hover:text-indigo-900" aria-label="Refresh" onclick="location.reload()">
          <i class="fa-solid fa-arrows-rotate"></i>
        </button>
      </td>`;
    return tr;
}

function statusDropdown(b) {
    const opts = STATUSES.map(s =>
        `<option value="${s}" ${s === b.status ? 'selected' : ''}>${s}</option>`).join('');
    return `
    <select data-id="${b.id}"
            class="status-select rounded-md border-gray-300 text-sm focus:ring-indigo-500 focus:border-indigo-500"
            onchange="handleStatusChange(this)">${opts}</select>`;
}

/* ---------- FILTER ---------- */
function applyFilter() {
    const val = statusFilter.value;
    filteredBookings = val === 'ALL'
        ? originalBookings
        : originalBookings.filter(b => b.status === val);
    renderTable(filteredBookings);
}

/* ---------- HANDLERS ---------- */
window.handleStatusChange = async function (sel) {
    const id = Number(sel.dataset.id);
    const newStatus = sel.value;

    const booking = originalBookings.find(b => b.id === id);
    if (!booking) return;

    const oldStatus = booking.status;
    booking.status = newStatus;          // mutate local
    sel.disabled = true;

    try {
        await updateBooking(booking);      // send FULL object
        applyFilter();                     // refresh table
        sel.classList.add('ring-2', 'ring-green-400');
    } catch {
        booking.status = oldStatus;        // rollback
        sel.value = oldStatus;
    } finally {
        sel.disabled = false;
        setTimeout(() => sel.classList.remove('ring-2', 'ring-green-400'), 1200);
    }
};

/* ---------- TOAST ---------- */
function showToast(msg, type = 'success') {
    toastMsg.textContent = msg;
    toast.className = `fixed bottom-5 right-5 flex items-center px-4 py-3 rounded-lg text-white shadow-lg transition
                     ${type === 'success' ? 'bg-green-600' : 'bg-red-600'}`;
    toast.classList.remove('hidden');
    setTimeout(() => toast.classList.add('hidden'), 3000);
}

/* ---------- INIT ---------- */
(async () => {
    originalBookings = await fetchBookings();
    applyFilter();
    statusFilter.addEventListener('change', applyFilter);
})();