/* eslint-disable no-undef */
const API_FEEDBACK = '/api/feedbacks';

const loader = document.getElementById('loader');
const tableWrapper = document.getElementById('tableWrapper');
const tbody = document.getElementById('feedback-tbody');

/* ===== API ===== */
async function fetchJson(url) {
    const res = await fetch(url);
    if (!res.ok) throw new Error('Network error');
    return res.json();
}

/* ===== Load ===== */
(async () => {
    try {
        const data = await fetchJson(API_FEEDBACK);
        renderTable(data);
    } catch (err) {
        console.error(err);
    } finally {
        loader.classList.add('hidden');
        tableWrapper.classList.remove('hidden');
    }
})();

/* ===== Render ===== */
function renderTable(list) {
    tbody.innerHTML = '';
    list.forEach(f => tbody.appendChild(renderRow(f)));
}

function renderRow(f) {
    const tr = document.createElement('tr');
    tr.className = 'hover:bg-gray-50';
    tr.innerHTML = `
      <td class="px-4 py-3 font-medium text-gray-900">${f.id}</td>
      <td class="px-4 py-3">${f.title}</td>
      <td class="px-4 py-3 max-w-xs truncate" title="${f.subTitle}">${f.subTitle}</td>
      <td class="px-4 py-3">${starIcons(f.numOfStars)}</td>
      <td class="px-4 py-3">${f.userName} <span class="text-gray-500">(${f.userEmail})</span></td>
      <td class="px-4 py-3">${new Date(f.createdAt).toLocaleString()}</td>`;
    return tr;
}

function starIcons(n) {
    return Array.from({ length: 5 }, (_, i) =>
        `<i class="fa-solid fa-star ${i < n ? 'text-yellow-400' : 'text-gray-300'}"></i>`
    ).join('');
}