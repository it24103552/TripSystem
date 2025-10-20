document.addEventListener('DOMContentLoaded', function() {
    const API_BASE = '/api/bookings';
    let currentUserId = null;
    let currentBookings = [];
    let filteredBookings = [];
    let activeFilter = 'all';
    let cancelBookingId = null;
    let deleteBookingId = null;

    // Initialize
    init();

    function init() {
        currentUserId = localStorage.getItem('userId');
        if (!currentUserId) {
            alert('Please login first');
            return;
        }

        loadBookings();
        setupEventListeners();
    }

    function setupEventListeners() {
        // Filter buttons
        document.getElementById('filterAll').addEventListener('click', () => setFilter('all'));
        document.getElementById('filterPending').addEventListener('click', () => setFilter('PENDING'));
        document.getElementById('filterConfirmed').addEventListener('click', () => setFilter('CONFIRMED'));
        document.getElementById('filterCompleted').addEventListener('click', () => setFilter('COMPLETED'));

        // Cancel modal
        document.getElementById('confirmCancel').addEventListener('click', confirmCancel);
        document.getElementById('cancelCancelAction').addEventListener('click', closeCancelModal);

        // Delete modal
        document.getElementById('confirmDelete').addEventListener('click', confirmDelete);
        document.getElementById('cancelDelete').addEventListener('click', closeDeleteModal);

        // Close modals on outside click
        document.getElementById('cancelModal').addEventListener('click', function(e) {
            if (e.target === this) closeCancelModal();
        });

        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) closeDeleteModal();
        });
    }

    async function loadBookings() {
        try {
            const response = await fetch(`${API_BASE}/customer/${currentUserId}`);
            if (response.ok) {
                currentBookings = await response.json();
                applyFilter();
                updateStats();
            } else {
                console.error('Failed to load bookings');
                renderNoBookings();
            }
        } catch (error) {
            console.error('Error loading bookings:', error);
            renderNoBookings();
        }
    }

    function setFilter(filter) {
        activeFilter = filter;

        // Update filter button styles
        document.querySelectorAll('[id^="filter"]').forEach(btn => {
            btn.classList.remove('bg-gray-200', 'text-gray-700', 'active-filter');
            btn.classList.add('bg-gray-100', 'text-gray-600');
        });

        const activeBtn = document.getElementById(`filter${filter.charAt(0).toUpperCase() + filter.slice(1).toLowerCase()}`);
        if (activeBtn) {
            activeBtn.classList.remove('bg-gray-100', 'text-gray-600');
            activeBtn.classList.add('bg-gray-200', 'text-gray-700', 'active-filter');
        }

        applyFilter();
    }

    function applyFilter() {
        if (activeFilter === 'all') {
            filteredBookings = currentBookings;
        } else {
            filteredBookings = currentBookings.filter(booking => booking.status === activeFilter);
        }
        renderBookings();
    }

    function updateStats() {
        const total = currentBookings.length;
        const pending = currentBookings.filter(b => b.status === 'PENDING').length;
        const confirmed = currentBookings.filter(b => b.status === 'CONFIRMED').length;
        const completed = currentBookings.filter(b => b.status === 'COMPLETED').length;

        document.getElementById('totalBookings').textContent = total;
        document.getElementById('pendingBookings').textContent = pending;
        document.getElementById('confirmedBookings').textContent = confirmed;
        document.getElementById('completedBookings').textContent = completed;
    }

    function renderBookings() {
        const container = document.getElementById('bookingsList');

        if (filteredBookings.length === 0) {
            if (activeFilter === 'all') {
                renderNoBookings();
            } else {
                container.innerHTML = `
                    <div class="text-center py-12">
                        <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <i class="fas fa-filter text-gray-400 text-3xl"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-600 mb-2">No ${activeFilter.toLowerCase()} bookings</h3>
                        <p class="text-gray-500">Try selecting a different filter</p>
                    </div>
                `;
            }
            return;
        }

        container.innerHTML = filteredBookings.map(booking => `
            <div class="border-2 border-gray-100 rounded-2xl p-6 card-hover pulse-border transition-all duration-300">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex-1">
                        <div class="flex items-center justify-between mb-3">
                            <h3 class="text-xl font-bold text-gray-800">Booking #${booking.id}</h3>
                            <span class="px-3 py-1 rounded-full text-sm font-medium status-${booking.status.toLowerCase()}">
                                ${getStatusIcon(booking.status)} ${formatStatus(booking.status)}
                            </span>
                        </div>
                        
                        <div class="grid md:grid-cols-2 gap-4 mb-4">
                            <div class="flex items-center text-gray-700">
                                <i class="fas fa-calendar-alt mr-3 text-green-500"></i>
                                <div>
                                    <p class="font-medium">Booking Date</p>
                                    <p class="text-sm">${formatDate(booking.bookingDate)}</p>
                                </div>
                            </div>
                            
                            <div class="flex items-center text-gray-700">
                                <i class="fas fa-user mr-3 text-blue-500"></i>
                                <div>
                                    <p class="font-medium">${escapeHtml(booking.customerName)}</p>
                                    <p class="text-sm text-gray-500">${escapeHtml(booking.customerEmail)}</p>
                                </div>
                            </div>
                        </div>
                        
                        ${booking.additionalNotes ? `
                            <div class="bg-gray-50 rounded-lg p-3 mb-4">
                                <p class="text-sm text-gray-600">
                                    <i class="fas fa-sticky-note mr-2 text-yellow-500"></i>
                                    <strong>Notes:</strong> ${escapeHtml(booking.additionalNotes)}
                                </p>
                            </div>
                        ` : ''}
                    </div>
                </div>
                
                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <div class="text-sm text-gray-500">
                        Booking ID: #${booking.id}
                    </div>
                    
                    <div class="flex space-x-3">
                        ${booking.status === 'PENDING' ? `
                            <button onclick="cancelBooking(${booking.id})" 
                                    class="bg-yellow-100 hover:bg-yellow-200 text-yellow-700 px-4 py-2 rounded-lg transition-colors duration-200 font-medium">
                                <i class="fas fa-times mr-1"></i>Cancel
                            </button>
                            <button onclick="deleteBooking(${booking.id})" 
                                    class="bg-red-100 hover:bg-red-200 text-red-700 px-4 py-2 rounded-lg transition-colors duration-200 font-medium">
                                <i class="fas fa-trash mr-1"></i>Delete
                            </button>
                        ` : ''}
                        
                        <button onclick="viewBookingDetails(${booking.id})" 
                                class="bg-blue-100 hover:bg-blue-200 text-blue-700 px-4 py-2 rounded-lg transition-colors duration-200 font-medium">
                            <i class="fas fa-eye mr-1"></i>View Details
                        </button>
                    </div>
                </div>
            </div>
        `).join('');
    }

    function renderNoBookings() {
        const container = document.getElementById('bookingsList');
        container.innerHTML = `
            <div class="text-center py-16">
                <div class="w-32 h-32 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <i class="fas fa-calendar-times text-gray-400 text-5xl"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-600 mb-3">No Bookings Found</h3>
                <p class="text-gray-500 mb-6">You haven't made any wildlife adventure bookings yet</p>
                <a href="/" 
                   class="bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-8 py-3 rounded-xl font-semibold transform hover:scale-105 transition-all duration-300 shadow-lg inline-block">
                    <i class="fas fa-binoculars mr-2"></i>Explore Wildlife Tours
                </a>
            </div>
        `;
    }

    function cancelBooking(bookingId) {
        cancelBookingId = bookingId;
        document.getElementById('cancelModal').classList.remove('hidden');
    }

    async function confirmCancel() {
        if (!cancelBookingId) return;

        try {
            const booking = currentBookings.find(b => b.id === cancelBookingId);
            const updateData = {
                bookingDate: booking.bookingDate,
                customerId: booking.customerId,
                additionalNotes: booking.additionalNotes,
                status: 'CANCELLED'
            };

            const response = await fetch(`${API_BASE}/${cancelBookingId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(updateData)
            });

            if (response.ok) {
                closeCancelModal();
                loadBookings();
                alert('Booking cancelled successfully');
            } else {
                const errorData = await response.text();
                alert('Error cancelling booking: ' + errorData);
            }
        } catch (error) {
            alert('Network error: ' + error.message);
        }
    }

    function deleteBooking(bookingId) {
        deleteBookingId = bookingId;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    async function confirmDelete() {
        if (!deleteBookingId) return;

        try {
            const response = await fetch(`${API_BASE}/${deleteBookingId}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                closeDeleteModal();
                loadBookings();
                alert('Booking deleted successfully');
            } else {
                const errorData = await response.text();
                alert('Error deleting booking: ' + errorData);
            }
        } catch (error) {
            alert('Network error: ' + error.message);
        }
    }

    function closeCancelModal() {
        document.getElementById('cancelModal').classList.add('hidden');
        cancelBookingId = null;
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
        deleteBookingId = null;
    }

    function viewBookingDetails(bookingId) {
        const booking = currentBookings.find(b => b.id === bookingId);
        if (booking) {
            alert(`Booking Details:\n\nID: #${booking.id}\nDate: ${formatDate(booking.bookingDate)}\nStatus: ${booking.status}\nCustomer: ${booking.customerName}\nEmail: ${booking.customerEmail}\n${booking.additionalNotes ? 'Notes: ' + booking.additionalNotes : ''}`);
        }
    }

    function getStatusIcon(status) {
        switch (status) {
            case 'PENDING': return '<i class="fas fa-clock"></i>';
            case 'CONFIRMED': return '<i class="fas fa-check-circle"></i>';
            case 'CANCELLED': return '<i class="fas fa-times-circle"></i>';
            case 'COMPLETED': return '<i class="fas fa-star"></i>';
            default: return '<i class="fas fa-question-circle"></i>';
        }
    }

    function formatStatus(status) {
        return status.charAt(0) + status.slice(1).toLowerCase();
    }

    function formatDate(dateString) {
        return new Date(dateString).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
    }

    function escapeHtml(text) {
        if (!text) return '';
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Make functions globally available
    window.cancelBooking = cancelBooking;
    window.deleteBooking = deleteBooking;
    window.viewBookingDetails = viewBookingDetails;
});