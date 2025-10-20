// Create Booking Management JavaScript
class BookingManager {
    constructor() {
        this.currentUser = null;
        this.packageName = '';
        this.packagePrice = 0;
        this.userId = null;

        this.init();
    }

    init() {
        // Get user ID from localStorage
        this.userId = localStorage.getItem('userId');

        if (!this.userId) {
            this.showAlert('Please login to continue with booking', 'error');
            setTimeout(() => {
                window.location.href = '/login';
            }, 2000);
            return;
        }

        // Get package details from URL parameters
        this.getUrlParameters();

        // Load user data
        this.loadUserData();

        // Set up form handlers
        this.setupEventListeners();

        // Set minimum date to today
        this.setMinimumDate();
    }

    getUrlParameters() {
        const urlParams = new URLSearchParams(window.location.search);
        this.packageName = urlParams.get('name') || 'Wildlife Adventure';
        this.packagePrice = parseFloat(urlParams.get('price')) || 0;

        // Update UI with package details
        document.getElementById('packageName').textContent = this.packageName;
        document.getElementById('packagePrice').textContent = `LKR ${this.packagePrice.toLocaleString()}`;

        // Set package name in additional notes for reference
        const notesField = document.getElementById('additionalNotes');
        notesField.value = `Selected Package: ${this.packageName}`;
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
            this.displayUserInfo();

        } catch (error) {
            console.error('Error loading user data:', error);
            this.showAlert('Failed to load user information. Please try again.', 'error');
        }
    }

    displayUserInfo() {
        const customerInfoDiv = document.getElementById('customerInfo');

        if (!this.currentUser) {
            customerInfoDiv.innerHTML = `
                <div class="text-red-500 text-center py-4">
                    <i class="fas fa-exclamation-triangle text-2xl mb-2"></i>
                    <p>Unable to load customer information</p>
                </div>
            `;
            return;
        }

        customerInfoDiv.innerHTML = `
            <div class="grid md:grid-cols-2 gap-6">
                <div>
                    <h4 class="font-semibold text-gray-700 mb-2">Personal Details</h4>
                    <div class="space-y-2">
                        <p class="flex items-center">
                            <i class="fas fa-user text-green-500 w-5 mr-2"></i>
                            <span class="font-medium">${this.currentUser.firstName} ${this.currentUser.lastName}</span>
                        </p>
                        <p class="flex items-center">
                            <i class="fas fa-envelope text-green-500 w-5 mr-2"></i>
                            <span>${this.currentUser.email}</span>
                        </p>
                        <p class="flex items-center">
                            <i class="fas fa-phone text-green-500 w-5 mr-2"></i>
                            <span>${this.currentUser.phoneNumber || 'Not provided'}</span>
                        </p>
                    </div>
                </div>
                <div>
                    <h4 class="font-semibold text-gray-700 mb-2">Additional Information</h4>
                    <div class="space-y-2">
                        <p class="flex items-center">
                            <i class="fas fa-globe text-green-500 w-5 mr-2"></i>
                            <span>${this.currentUser.country || 'Not specified'}</span>
                        </p>
                        <p class="flex items-center">
                            <i class="fas fa-car text-green-500 w-5 mr-2"></i>
                            <span>Vehicle: ${this.currentUser.vehicleType || 'Not specified'}</span>
                        </p>
                        <p class="flex items-center">
                            <i class="fas fa-language text-green-500 w-5 mr-2"></i>
                            <span>Language: ${this.currentUser.language || 'Not specified'}</span>
                        </p>
                    </div>
                </div>
            </div>
        `;
    }

    setupEventListeners() {
        // Form submission
        document.getElementById('bookingForm').addEventListener('submit', (e) => {
            e.preventDefault();
            this.submitBooking();
        });

        // Number of people change - update total bill
        document.getElementById('numberOfPeople').addEventListener('change', () => {
            this.updateTotalBill();
        });
    }

    setMinimumDate() {
        const today = new Date();
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);

        const minDate = tomorrow.toISOString().split('T')[0];
        document.getElementById('bookingDate').min = minDate;
    }

    updateTotalBill() {
        const numberOfPeople = parseInt(document.getElementById('numberOfPeople').value) || 1;
        const totalBill = this.packagePrice * numberOfPeople;

        document.getElementById('totalBill').textContent = `LKR ${totalBill.toLocaleString()}`;
    }

    async submitBooking() {
        const submitBtn = document.getElementById('submitBtn');
        const submitText = document.getElementById('submitText');
        const loadingText = document.getElementById('loadingText');

        // Show loading state
        submitBtn.disabled = true;
        submitText.classList.add('hidden');
        loadingText.classList.add('show');

        try {
            // Get form data
            const formData = this.getFormData();

            // Validate form data
            if (!this.validateForm(formData)) {
                throw new Error('Please fill in all required fields');
            }

            // Create booking request
            const bookingData = {
                bookingDate: formData.bookingDate,
                customerId: parseInt(this.userId),
                additionalNotes: formData.additionalNotes,
                status: 'PENDING'
            };

            // Submit booking to API
            const response = await fetch('/api/bookings', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(bookingData)
            });

            if (!response.ok) {
                const errorText = await response.text();
                throw new Error(errorText || 'Failed to create booking');
            }

            const bookingResponse = await response.json();

            // Calculate total bill
            const numberOfPeople = parseInt(formData.numberOfPeople);
            const totalBill = this.packagePrice * numberOfPeople;

            // Show success message
            this.showAlert('Booking created successfully! Redirecting to payment...', 'success');

            // Redirect to payment page after 2 seconds
            setTimeout(() => {
                window.location.href = `/create-payment?bookingId=${bookingResponse.id}&totalBill=${totalBill}`;
            }, 2000);

        } catch (error) {
            console.error('Error creating booking:', error);
            this.showAlert(error.message || 'Failed to create booking. Please try again.', 'error');
        } finally {
            // Reset button state
            submitBtn.disabled = false;
            submitText.classList.remove('hidden');
            loadingText.classList.remove('show');
        }
    }

    getFormData() {
        return {
            bookingDate: document.getElementById('bookingDate').value,
            numberOfPeople: document.getElementById('numberOfPeople').value,
            additionalNotes: document.getElementById('additionalNotes').value
        };
    }

    validateForm(formData) {
        if (!formData.bookingDate) {
            this.showAlert('Please select a booking date', 'error');
            return false;
        }

        if (!formData.numberOfPeople) {
            this.showAlert('Please select number of people', 'error');
            return false;
        }

        // Check if date is in the future
        const selectedDate = new Date(formData.bookingDate);
        const today = new Date();
        today.setHours(0, 0, 0, 0);

        if (selectedDate <= today) {
            this.showAlert('Please select a future date for your booking', 'error');
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
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle text-xl mr-3"></i>
                    <span>${message}</span>
                </div>
            `;
        } else if (type === 'success') {
            alertDiv.classList.add('success');
            alertDiv.innerHTML = `
                <div class="flex items-center">
                    <i class="fas fa-check-circle text-xl mr-3"></i>
                    <span>${message}</span>
                </div>
            `;
        }

        // Show the alert
        alertDiv.classList.remove('hidden');

        // Auto-hide after 5 seconds for success messages
        if (type === 'success') {
            setTimeout(() => {
                alertDiv.classList.add('hidden');
            }, 5000);
        }

        // Scroll to top to show alert
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
}

// Initialize booking manager when page loads
document.addEventListener('DOMContentLoaded', () => {
    new BookingManager();
});

// Utility function to handle API errors
function handleApiError(error, fallbackMessage) {
    console.error('API Error:', error);

    if (error instanceof TypeError && error.message.includes('fetch')) {
        return 'Network error. Please check your connection and try again.';
    }

    return error.message || fallbackMessage || 'An unexpected error occurred.';
}