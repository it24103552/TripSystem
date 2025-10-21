document.addEventListener('DOMContentLoaded', function() {
    const API_BASE = '/api/payments';
    let currentUserId = null;

    init();

    function init() {
        currentUserId = localStorage.getItem('userId');
        if (!currentUserId) {
            alert('Please login first');
            return;
        }

        loadPayments();
    }

    async function loadPayments() {
        try {
            const response = await fetch(`${API_BASE}/user/${currentUserId}`);
            if (response.ok) {
                const payments = await response.json();
                renderPayments(payments);
            } else {
                console.error('Failed to load payments');
                renderNoPayments();
            }
        } catch (error) {
            console.error('Error loading payments:', error);
            renderNoPayments();
        }
    }

    function renderPayments(payments) {
        const container = document.getElementById('paymentsList');

        if (payments.length === 0) {
            renderNoPayments();
            return;
        }

        container.innerHTML = payments.map(payment => `
            <div class="border-2 border-gray-100 rounded-2xl p-6 card-hover pulse-border transition-all duration-300">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex-1">
                        <div class="flex items-center justify-between mb-3">
                            <h3 class="text-xl font-bold text-gray-800">Payment #${payment.id}</h3>
                            <span class="px-3 py-1 rounded-full text-sm font-medium ${getStatusClass(payment.status)}">
                                ${getStatusIcon(payment.status)} ${payment.status}
                            </span>
                        </div>
                        
                        <div class="grid md:grid-cols-2 gap-4 mb-4">
                            <div class="flex items-center text-gray-700">
                                <i class="fas fa-money-bill-wave mr-3 text-green-500"></i>
                                <div>
                                    <p class="font-medium">Amount</p>
                                    <p class="text-lg font-bold text-green-600">LKR ${parseFloat(payment.amount).toLocaleString()}</p>
                                </div>
                            </div>
                            
                            <div class="flex items-center text-gray-700">
                                <i class="fas fa-credit-card mr-3 text-blue-500"></i>
                                <div>
                                    <p class="font-medium">Payment Method</p>
                                    <p class="text-sm">${payment.method}</p>
                                </div>
                            </div>
                            
                            <div class="flex items-center text-gray-700">
                                <i class="fas fa-calendar-alt mr-3 text-purple-500"></i>
                                <div>
                                    <p class="font-medium">Booking Date</p>
                                    <p class="text-sm">${payment.bookingDate}</p>
                                </div>
                            </div>
                            
                            <div class="flex items-center text-gray-700">
                                <i class="fas fa-ticket-alt mr-3 text-orange-500"></i>
                                <div>
                                    <p class="font-medium">Booking ID</p>
                                    <p class="text-sm">#${payment.paidToBookingId}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="flex justify-between items-center pt-4 border-t border-gray-100">
                    <div class="text-sm text-gray-500">
                        Payment ID: #${payment.id}
                    </div>
                    ${payment.deleteStatus ?
            '<span class="bg-red-100 text-red-700 px-3 py-1 rounded-full text-sm font-medium">Inactive</span>' :
            '<span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-medium">Active</span>'
        }
                </div>
            </div>
        `).join('');
    }

    function renderNoPayments() {
        const container = document.getElementById('paymentsList');
        container.innerHTML = `
            <div class="text-center py-16">
                <div class="w-32 h-32 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
                    <i class="fas fa-wallet text-gray-400 text-5xl"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-600 mb-3">No Payments Found</h3>
                <p class="text-gray-500 mb-6">You haven't made any payments yet</p>
                <a href="/" 
                   class="bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-8 py-3 rounded-xl font-semibold transform hover:scale-105 transition-all duration-300 shadow-lg inline-block">
                    <i class="fas fa-binoculars mr-2"></i>Explore Wildlife Tours
                </a>
            </div>
        `;
    }

    function getStatusIcon(status) {
        switch (status.toUpperCase()) {
            case 'COMPLETED': return '<i class="fas fa-check-circle"></i>';
            case 'PENDING': return '<i class="fas fa-clock"></i>';
            case 'FAILED': return '<i class="fas fa-times-circle"></i>';
            case 'CANCELLED': return '<i class="fas fa-ban"></i>';
            default: return '<i class="fas fa-question-circle"></i>';
        }
    }

    function getStatusClass(status) {
        switch (status.toUpperCase()) {
            case 'COMPLETED': return 'bg-green-100 text-green-800';
            case 'PENDING': return 'bg-yellow-100 text-yellow-800';
            case 'FAILED': return 'bg-red-100 text-red-800';
            case 'CANCELLED': return 'bg-gray-100 text-gray-800';
            default: return 'bg-blue-100 text-blue-800';
        }
    }
});