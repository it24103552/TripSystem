document.addEventListener('DOMContentLoaded', function() {
    const API_BASE = '/api/users';
    let currentUserId = null;

    init();

    function init() {
        currentUserId = localStorage.getItem('userId');
        if (!currentUserId) {
            alert('Please login first');
            window.location.replace('/');
            return;
        }

        loadUserProfile();
        setupEventListeners();
    }

    function setupEventListeners() {
        document.getElementById('profileForm').addEventListener('submit', handleUpdate);
        document.getElementById('deleteBtn').addEventListener('click', showDeleteModal);
        document.getElementById('logoutBtn').addEventListener('click', handleLogout);
        document.getElementById('confirmDelete').addEventListener('click', handleDelete);
        document.getElementById('cancelDelete').addEventListener('click', hideDeleteModal);

        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) hideDeleteModal();
        });
    }

    async function loadUserProfile() {
        try {
            const response = await fetch(`${API_BASE}/${currentUserId}`);
            if (response.ok) {
                const user = await response.json();
                populateForm(user);
                showCurrentValues(user);
            } else {
                alert('Failed to load profile');
            }
        } catch (error) {
            alert('Error loading profile: ' + error.message);
        }
    }

    function populateForm(user) {
        document.getElementById('firstName').value = user.firstName || '';
        document.getElementById('lastName').value = user.lastName || '';
        document.getElementById('email').value = user.email || '';
        document.getElementById('phoneNumber').value = user.phoneNumber || '';
        document.getElementById('country').value = user.country || '';
    }

    function showCurrentValues(user) {
        addCurrentValueDisplay('firstName', user.firstName);
        addCurrentValueDisplay('lastName', user.lastName);
        addCurrentValueDisplay('email', user.email);
        addCurrentValueDisplay('phoneNumber', user.phoneNumber);
        addCurrentValueDisplay('country', user.country);
    }

    function addCurrentValueDisplay(fieldId, currentValue) {
        const field = document.getElementById(fieldId);
        const label = field.previousElementSibling;

        if (currentValue && currentValue.trim()) {
            const currentValueSpan = document.createElement('span');
            currentValueSpan.className = 'text-sm text-gray-500 ml-2';
            currentValueSpan.textContent = `(Current: ${currentValue})`;
            currentValueSpan.id = `${fieldId}CurrentValue`;
            label.appendChild(currentValueSpan);

            field.addEventListener('input', function() {
                const currentSpan = document.getElementById(`${fieldId}CurrentValue`);
                if (this.value.trim() === currentValue.trim()) {
                    if (currentSpan) currentSpan.style.display = 'inline';
                } else {
                    if (currentSpan) currentSpan.style.display = 'none';
                }
            });
        }
    }

    async function handleUpdate(e) {
        e.preventDefault();

        if (!validateForm()) {
            return;
        }

        const formData = {
            firstName: document.getElementById('firstName').value.trim(),
            lastName: document.getElementById('lastName').value.trim(),
            email: document.getElementById('email').value.trim(),
            phoneNumber: document.getElementById('phoneNumber').value.trim(),
            country: document.getElementById('country').value.trim(),
            userRole:"TRAVELER"
        };

        try {
            const response = await fetch(`${API_BASE}/${currentUserId}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(formData)
            });

            if (response.ok) {
                alert('Profile updated successfully');
            } else {
                const errorData = await response.text();
                alert('Error updating profile: ' + errorData);
            }
        } catch (error) {
            alert('Network error: ' + error.message);
        }
    }

    function validateForm() {
        let isValid = true;

        const firstName = document.getElementById('firstName').value.trim();
        const firstNameError = document.getElementById('firstNameError');
        const firstNameRegex = /^[A-Za-z]{2,}$/;

        if (!firstName || !firstNameRegex.test(firstName)) {
            firstNameError.classList.remove('hidden');
            isValid = false;
        } else {
            firstNameError.classList.add('hidden');
        }

        const lastName = document.getElementById('lastName').value.trim();
        const lastNameError = document.getElementById('lastNameError');
        const lastNameRegex = /^[A-Za-z]{2,}$/;

        if (!lastName || !lastNameRegex.test(lastName)) {
            lastNameError.classList.remove('hidden');
            isValid = false;
        } else {
            lastNameError.classList.add('hidden');
        }

        const email = document.getElementById('email').value.trim();
        const emailError = document.getElementById('emailError');
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!email || !emailRegex.test(email)) {
            emailError.classList.remove('hidden');
            isValid = false;
        } else {
            emailError.classList.add('hidden');
        }

        const phoneNumber = document.getElementById('phoneNumber').value.trim();
        const phoneNumberError = document.getElementById('phoneNumberError');
        const phoneRegex = /^[\+]?[0-9]{10,15}$/;

        if (!phoneNumber || !phoneRegex.test(phoneNumber)) {
            phoneNumberError.classList.remove('hidden');
            isValid = false;
        } else {
            phoneNumberError.classList.add('hidden');
        }

        const country = document.getElementById('country').value.trim();
        const countryError = document.getElementById('countryError');
        const countryRegex = /^[A-Za-z\s]{2,}$/;

        if (!country || !countryRegex.test(country)) {
            countryError.classList.remove('hidden');
            isValid = false;
        } else {
            countryError.classList.add('hidden');
        }

        return isValid;
    }

    function showDeleteModal() {
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function hideDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }

    async function handleDelete() {
        try {
            const response = await fetch(`${API_BASE}/${currentUserId}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                alert('Account deleted successfully');
                clearStorage();
                window.location.replace('/');
            } else {
                const errorData = await response.text();
                alert('Error deleting account: ' + errorData);
            }
        } catch (error) {
            alert('Network error: ' + error.message);
        }
    }

    function handleLogout() {
        if (confirm('Are you sure you want to logout?')) {
            clearStorage();
            window.location.replace('/');
        }
    }

    function clearStorage() {
        localStorage.clear();
        sessionStorage.clear();
    }
});