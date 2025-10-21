// Create Payment Management JavaScript
class PaymentManager {
    constructor() {
        this.bookingId = null;
        this.totalBill = 0;
        this.userId = null;
        this.selectedPaymentMethod = null;
        this.currentUser = null;
        this.bookingDetails = null;

        this.init();
    }

    init() {
        // Get user ID from localStorage
        this.userId = localStorage.getItem('userId');

        if (!this.userId) {
            this.showAlert('Please login to continue with payment', 'error');
            setTimeout(() => {
                window.location.href = '/login';
            }, 2000);
            return;
        }

        // Get payment details from URL parameters
        this.getUrlParameters();

        // Load user and booking data
        this.loadUserData();
        this.loadBookingData();

        // Set up event listeners
        this.setupEventListeners();
    }

    getUrlParameters() {
        const urlParams = new URLSearchParams(window.location.search);
        this.bookingId = urlParams.get('bookingId');
        this.totalBill = parseFloat(urlParams.get('totalBill')) || 0;

        if (!this.bookingId || this.totalBill <= 0) {
            this.showAlert('Invalid payment parameters. Please try booking again.', 'error');
            setTimeout(() => {
                window.location.href = '/';
            }, 3000);
            return;
        }
    }

    async loadUserData() {
        try {
            const response = await fetch(`/api/users/${this.userId}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to load user data');
            }

            this.currentUser = await response.json();

        } catch (error) {
            console.error('Error loading user data:', error);
            this.showAlert('Failed to load user information. Please try again.', 'error');
        }
    }

    async loadBookingData() {
        try {
            const response = await fetch(`/api/bookings/${this.bookingId}`, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) {
                throw new Error('Failed to load booking data');
            }

            this.bookingDetails = await response.json();
            this.displayBookingSummary();

        } catch (error) {
            console.error('Error loading booking data:', error);
            this.showAlert('Failed to load booking information. Please try again.', 'error');
        }
    }

    displayBookingSummary() {
        const summaryDiv = document.getElementById('bookingSummary');

        if (!this.bookingDetails) {
            summaryDiv.innerHTML = `
                <div class="text-red-500 text-center py-4">
                    <i class="fas fa-exclamation-triangle text-2xl mb-2"></i>
                    <p>Unable to load booking information</p>
                </div>
            `;
            return;
        }

        summaryDiv.innerHTML = `
            <div class="space-y-4">
                <div class="flex justify-between items-center">
                    <span class="text-gray-600">Booking ID:</span>
                    <span class="font-bold text-gray-800">#${this.bookingDetails.id}</span>
                </div>
                <div class="flex justify-between items-center">
                    <span class="text-gray-600">Customer:</span>
                    <span class="font-semibold text-gray-800">${this.bookingDetails.customerName}</span>
                </div>
                <div class="flex justify-between items-center">
                    <span class="text-gray-600">Tour Date:</span>
                    <span class="font-semibold text-gray-800">${new Date(this.bookingDetails.bookingDate).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        })}</span>
                </div>
                <div class="flex justify-between items-center">
                    <span class="text-gray-600">Status:</span>
                    <span class="px-3 py-1 rounded-full text-sm font-semibold ${this.getStatusColor(this.bookingDetails.status)}">
                        ${this.bookingDetails.status}
                    </span>
                </div>
                <div class="border-t pt-4">
                    <div class="flex justify-between items-center text-2xl font-bold">
                        <span class="text-gray-800">Total Amount:</span>
                        <span class="text-green-600">LKR ${this.totalBill.toLocaleString()}</span>
                    </div>
                </div>
                ${this.bookingDetails.additionalNotes ? `
                    <div class="bg-blue-50 p-3 rounded-lg">
                        <p class="text-sm text-gray-700">
                            <strong>Notes:</strong> ${this.bookingDetails.additionalNotes}
                        </p>
                    </div>
                ` : ''}
            </div>
        `;
    }

    getStatusColor(status) {
        switch (status.toUpperCase()) {
            case 'PENDING':
                return 'bg-yellow-100 text-yellow-800';
            case 'CONFIRMED':
                return 'bg-green-100 text-green-800';
            case 'CANCELLED':
                return 'bg-red-100 text-red-800';
            default:
                return 'bg-gray-100 text-gray-800';
        }
    }

    setupEventListeners() {
        // Payment method selection
        document.querySelectorAll('.payment-method').forEach(method => {
            method.addEventListener('click', (e) => {
                this.selectPaymentMethod(method);
            });
        });

        // Card input formatting
        this.setupCardInputs();

        // Payment form submission
        document.getElementById('paymentBtn').addEventListener('click', () => {
            this.processPayment();
        });
    }

    selectPaymentMethod(selectedElement) {
        // Remove selection from all methods
        document.querySelectorAll('.payment-method').forEach(method => {
            method.classList.remove('selected');
        });

        // Add selection to clicked method
        selectedElement.classList.add('selected');
        this.selectedPaymentMethod = selectedElement.dataset.method;

        // Show/hide relevant forms
        this.togglePaymentForms();
    }

    togglePaymentForms() {
        const cardForm = document.getElementById('cardPaymentForm');
        const bankInfo = document.getElementById('bankTransferInfo');
        const cashInfo = document.getElementById('cashPaymentInfo');
        const paymentBtn = document.getElementById('paymentBtn');
        const paymentText = document.getElementById('paymentText');

        // Hide all forms
        cardForm.classList.add('hidden');
        bankInfo.classList.add('hidden');
        cashInfo.classList.add('hidden');

        // Show relevant form and update button text
        switch (this.selectedPaymentMethod) {
            case 'CARD':
                cardForm.classList.remove('hidden');
                paymentText.innerHTML = '<i class="fas fa-credit-card mr-2"></i>Complete Card Payment';
                break;
            case 'BANK_TRANSFER':
                bankInfo.classList.remove('hidden');
                paymentText.innerHTML = '<i class="fas fa-university mr-2"></i>Confirm Bank Transfer';
                break;
            case 'CASH':
                cashInfo.classList.remove('hidden');
                paymentText.innerHTML = '<i class="fas fa-money-bill-wave mr-2"></i>Confirm Cash Payment';
                break;
        }
    }

    setupCardInputs() {
        const cardNumber = document.getElementById('cardNumber');
        const expiryDate = document.getElementById('expiryDate');
        const cvv = document.getElementById('cvv');
        const cardholderName = document.getElementById('cardholderName');

        // Card number formatting and validation
        cardNumber.addEventListener('input', (e) => {
            let value = e.target.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
            let formattedValue = value.match(/.{1,4}/g)?.join(' ') || value;

            e.target.value = formattedValue;
            this.updateVirtualCard();
            this.detectCardType(value);
        });

        // Expiry date formatting
        expiryDate.addEventListener('input', (e) => {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            e.target.value = value;
            this.updateVirtualCard();
        });

        // CVV input
        cvv.addEventListener('input', (e) => {
            e.target.value = e.target.value.replace(/[^0-9]/gi, '').substring(0, 4);
            this.updateVirtualCard();
        });

        // CVV focus - flip card
        cvv.addEventListener('focus', () => {
            document.getElementById('virtualCard').classList.add('flipped');
        });

        cvv.addEventListener('blur', () => {
            document.getElementById('virtualCard').classList.remove('flipped');
        });

        // Cardholder name
        cardholderName.addEventListener('input', () => {
            this.updateVirtualCard();
        });
    }

    detectCardType(number) {
        const cardTypeIcon = document.getElementById('cardTypeIcon');
        const cardTypeLogo = document.getElementById('cardTypeLogo');

        let cardType = '';
        let icon = '';
        let logo = '';

        if (/^4/.test(number)) {
            cardType = 'visa';
            icon = '<i class="fab fa-cc-visa text-blue-600 text-2xl"></i>';
            logo = '<i class="fab fa-cc-visa text-4xl"></i>';
        } else if (/^5[1-5]/.test(number)) {
            cardType = 'mastercard';
            icon = '<i class="fab fa-cc-mastercard text-red-600 text-2xl"></i>';
            logo = '<i class="fab fa-cc-mastercard text-4xl"></i>';
        } else if (/^3[47]/.test(number)) {
            cardType = 'amex';
            icon = '<i class="fab fa-cc-amex text-green-600 text-2xl"></i>';
            logo = '<i class="fab fa-cc-amex text-4xl"></i>';
        } else {
            icon = '<i class="fas fa-credit-card text-gray-400 text-2xl"></i>';
            logo = '<i class="fas fa-credit-card text-4xl"></i>';
        }

        cardTypeIcon.innerHTML = icon;
        cardTypeLogo.innerHTML = logo;
    }

    updateVirtualCard() {
        const cardNumber = document.getElementById('cardNumber').value || '•••• •••• •••• ••••';
        const expiryDate = document.getElementById('expiryDate').value || 'MM/YY';
        const cvv = document.getElementById('cvv').value || 'CVV';
        const cardholderName = document.getElementById('cardholderName').value.toUpperCase() || 'YOUR NAME';

        document.getElementById('displayCardNumber').textContent = cardNumber;
        document.getElementById('displayExpiryDate').textContent = expiryDate;
        document.getElementById('displayCVV').textContent = cvv;
        document.getElementById('displayCardholderName').textContent = cardholderName;
    }

    async processPayment() {
        const paymentBtn = document.getElementById('paymentBtn');
        const paymentText = document.getElementById('paymentText');
        const loadingText = document.getElementById('loadingPaymentText');

        if (!this.selectedPaymentMethod) {
            this.showAlert('Please select a payment method', 'error');
            return;
        }

        // Validate card details if card payment selected
        if (this.selectedPaymentMethod === 'CARD' && !this.validateCardDetails()) {
            return;
        }

        // Show loading state
        paymentBtn.disabled = true;
        paymentText.classList.add('hidden');
        loadingText.classList.add('show');

        try {
            // Create payment request
            const paymentData = {
                deleteStatus: false,
                status: 'COMPLETED',
                amount: this.totalBill,
                method: this.selectedPaymentMethod,
                paidBy: parseInt(this.userId),
                paidTo: parseInt(this.bookingId)
            };

            // Submit payment to API
            const response = await fetch('/api/payments', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(paymentData)
            });

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(errorText || 'Failed to process payment');
            }

            const paymentResponse = await response.json();

            // Show success message
            this.showAlert('Payment processed successfully! Your booking is confirmed.', 'success');

            // Store payment details for confirmation
            localStorage.setItem('lastPaymentId', paymentResponse.id);
            localStorage.setItem('lastBookingId', this.bookingId);

            // Redirect to success page after 3 seconds
            setTimeout(() => {
                window.location.href = `/payment-success?paymentId=${paymentResponse.id}&bookingId=${this.bookingId}`;
            }, 3000);

        } catch (error) {
            console.error('Error processing payment:', error);
            this.showAlert(error.message || 'Failed to process payment. Please try again.', 'error');
        } finally {
            // Reset button state
            paymentBtn.disabled = false;
            paymentText.classList.remove('hidden');
            loadingText.classList.remove('show');
        }
    }

    validateCardDetails() {
        const cardNumber = document.getElementById('cardNumber').value.replace(/\s+/g, '');
        const expiryDate = document.getElementById('expiryDate').value;
        const cvv = document.getElementById('cvv').value;
        const cardholderName = document.getElementById('cardholderName').value.trim();

        // Card number validation
        if (!cardNumber || cardNumber.length < 13) {
            this.showAlert('Please enter a valid card number', 'error');
            return false;
        }

        // Expiry date validation
        if (!expiryDate || !/^\d{2}\/\d{2}$/.test(expiryDate)) {
            this.showAlert('Please enter a valid expiry date (MM/YY)', 'error');
            return false;
        }

        // Check if card is not expired
        const [month, year] = expiryDate.split('/').map(num => parseInt(num));
        const currentDate = new Date();
        const currentMonth = currentDate.getMonth() + 1;
        const currentYear = currentDate.getFullYear() % 100;

        if (year < currentYear || (year === currentYear && month < currentMonth)) {
            this.showAlert('Card has expired. Please use a valid card.', 'error');
            return false;
        }

        // CVV validation
        if (!cvv || cvv.length < 3) {
            this.showAlert('Please enter a valid CVV', 'error');
            return false;
        }

        // Cardholder name validation
        if (!cardholderName || cardholderName.length < 2) {
            this.showAlert('Please enter the cardholder name', 'error');
            return false;
        }

        // Dummy card validation for testing
        return this.validateDummyCard(cardNumber, expiryDate, cvv);
    }

    validateDummyCard(cardNumber, expiryDate, cvv) {
        // Dummy valid card numbers for testing
        const validCards = [
            '4111111111111111', // Visa
            '5555555555554444', // Mastercard
            '378282246310005',  // Amex
            '4000000000000002', // Visa
            '5200828282828210', // Mastercard
            '4242424242424242', // Visa (Stripe test)
            '5105105105105100'  // Mastercard (Stripe test)
        ];

        const cleanCardNumber = cardNumber.replace(/\s+/g, '');

        if (!validCards.includes(cleanCardNumber)) {
            this.showAlert('Please use a valid test card number:\n• 4111 1111 1111 1111 (Visa)\n• 5555 5555 5555 4444 (Mastercard)\n• 3782 8224 6310 005 (Amex)', 'error');
            return false;
        }

        // Valid expiry dates (future dates)
        const [month, year] = expiryDate.split('/').map(num => parseInt(num));
        const currentDate = new Date();
        const currentYear = currentDate.getFullYear() % 100;

        if (year < currentYear + 1) {
            this.showAlert('Please use a future expiry date for testing', 'error');
            return false;
        }

        // Valid CVV for testing
        if (!['123', '1234', '999', '000'].includes(cvv)) {
            this.showAlert('Please use a valid test CVV: 123, 1234, 999, or 000', 'error');
            return false;
        }

        return true;
    }

    showAlert(message, type) {
        const alertDiv = document.getElementById('alertMessage');

        // Remove existing classes
        alertDiv.className = 'mb-6 p-4 rounded-lg border';

        // Add appropriate classes based on type
        if (type === 'error') {
            alertDiv.classList.add('error');
            alertDiv.innerHTML = `
                <div class="flex items-start">
                    <i class="fas fa-exclamation-circle text-xl mr-3 mt-1"></i>
                    <div>
                        <h4 class="font-bold mb-1">Payment Error</h4>
                        <p class="whitespace-pre-line">${message}</p>
                    </div>
                </div>
            `;
        } else if (type === 'success') {
            alertDiv.classList.add('success');
            alertDiv.innerHTML = `
                <div class="flex items-start">
                    <i class="fas fa-check-circle text-xl mr-3 mt-1"></i>
                    <div>
                        <h4 class="font-bold mb-1">Payment Successful</h4>
                        <p>${message}</p>
                    </div>
                </div>
            `;
        }

        // Show the alert
        alertDiv.classList.remove('hidden');

        // Auto-hide success messages after 8 seconds
        if (type === 'success') {
            setTimeout(() => {
                alertDiv.classList.add('hidden');
            }, 8000);
        }

        // Scroll to top to show alert
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
}

// Initialize payment manager when page loads
document.addEventListener('DOMContentLoaded', () => {
    new PaymentManager();
});

// Utility functions for card validation
function luhnCheck(cardNumber) {
    let sum = 0;
    let isEven = false;

    // Loop through values starting from the rightmost side
    for (let i = cardNumber.length - 1; i >= 0; i--) {
        let digit = parseInt(cardNumber[i]);

        if (isEven) {
            digit *= 2;
            if (digit > 9) {
                digit -= 9;
            }
        }

        sum += digit;
        isEven = !isEven;
    }

    return (sum % 10) === 0;
}

// Format currency for display
function formatCurrency(amount) {
    return new Intl.NumberFormat('en-LK', {
        style: 'currency',
        currency: 'LKR',
        minimumFractionDigits: 0
    }).format(amount);
}

// Handle API errors
function handleApiError(error, fallbackMessage) {
    console.error('Payment API Error:', error);

    if (error instanceof TypeError && error.message.includes('fetch')) {
        return 'Network error. Please check your connection and try again.';
    }

    return error.message || fallbackMessage || 'An unexpected error occurred during payment processing.';
}