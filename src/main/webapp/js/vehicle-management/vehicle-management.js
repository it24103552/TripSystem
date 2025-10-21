document.addEventListener('DOMContentLoaded', function() {
    // All code runs AFTER page loads

    const API_BASE = '/api/vehicles';  // Base URL for API calls
    let allVehicles = [];              // Stores all vehicles
    let filteredVehicles = [];         // Stores filtered vehicles (after search)
    let isEditing = false;             // Are we editing or creating?
    let editingId = null;              // ID of vehicle being edited
    let deleteId = null;               // ID of vehicle to delete

    // Initialize
    init(); // Start the application

    function init() {
        loadVehicles();  // Fetch vehicles from backend
        setupEventListeners(); // Attach click handlers to buttons
    }

    function setupEventListeners() {
        // Search functionality
        // When user types in search box
        document.getElementById('searchInput').addEventListener('input', handleSearch);

        // Modal controls
        // When "Add vehicle" button is clicked
        document.getElementById('addVehicleBtn').addEventListener('click', openCreateModal);
        document.getElementById('closeModalBtn').addEventListener('click', closeModal);
        document.getElementById('cancelBtn').addEventListener('click', closeModal);

        // Form submission
        // When form is submitted
        document.getElementById('vehicleForm').addEventListener('submit', handleSubmit);

        // Delete modal
        document.getElementById('confirmDeleteBtn').addEventListener('click', confirmDelete);
        document.getElementById('cancelDeleteBtn').addEventListener('click', closeDeleteModal);

        // Close modals on outside click
        document.getElementById('vehicleModal').addEventListener('click', function(e) {
            if (e.target === this) closeModal();
        });

        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) closeDeleteModal();
        });
    }

    async function loadVehicles() {
        showLoading();
        try {
            const response = await fetch(API_BASE);
            if (response.ok) {
                allVehicles = await response.json();
                filteredVehicles = [...allVehicles];
                renderVehicles();
            } else {
                console.error('Failed to load vehicles');
                showError('Failed to load vehicles');
            }
        } catch (error) {
            console.error('Error loading vehicles:', error);
            showError('Network error while loading vehicles');
        } finally {
            hideLoading();
        }
    }

    function handleSearch(e) {
        const searchTerm = e.target.value.toLowerCase().trim();

        if (!searchTerm) {
            // No search term, show all vehicles
            filteredVehicles = [...allVehicles];
        } else {
            // Filter vehicles based on search term
            filteredVehicles = allVehicles.filter(vehicle =>
                vehicle.vehicleNumber.toLowerCase().includes(searchTerm) ||
                vehicle.type.toLowerCase().includes(searchTerm) ||
                vehicle.numOfSeats.toString().includes(searchTerm)
            );
        }

        renderVehicles();
    }

    function renderVehicles() {
        const grid = document.getElementById('vehiclesGrid');
        const emptyState = document.getElementById('emptyState');

        if (filteredVehicles.length === 0) {
            // Show "No vehicles found" message
            grid.innerHTML = '';
            emptyState.classList.remove('hidden');
            return;
        }

        emptyState.classList.add('hidden');

        // Generate HTML for each vehicle
        grid.innerHTML = filteredVehicles.map(vehicle => `
            <div class="bg-white rounded-lg shadow-sm border card-hover">
                <div class="p-6">
                    <div class="flex justify-between items-start mb-4">
                        <div>
                            <h3 class="text-lg font-semibold text-gray-900">${escapeHtml(vehicle.vehicleNumber)}</h3>
                            <p class="text-sm text-gray-600">${escapeHtml(vehicle.type)}</p>
                        </div>
                        <div class="flex gap-2">
                            ${vehicle.availability ?
            '<span class="px-2 py-1 bg-green-100 text-green-800 rounded-full text-xs font-medium">Available</span>' :
            '<span class="px-2 py-1 bg-red-100 text-red-800 rounded-full text-xs font-medium">Unavailable</span>'
        }
                            ${vehicle.deleteStatus ?
            '<span class="px-2 py-1 bg-gray-100 text-gray-800 rounded-full text-xs font-medium">Inactive</span>' :
            '<span class="px-2 py-1 bg-blue-100 text-blue-800 rounded-full text-xs font-medium">Active</span>'
        }
                        </div>
                    </div>
                    
                    <div class="space-y-2 mb-4">
                        <div class="flex items-center text-sm text-gray-600">
                            <i class="fas fa-users w-4 mr-2"></i>
                            <span>${vehicle.numOfSeats} seats</span>
                        </div>
                        <div class="flex items-center text-sm text-gray-600">
                            <i class="fas fa-snowflake w-4 mr-2"></i>
                            <span>${vehicle.haveAc ? 'Air Conditioned' : 'No AC'}</span>
                        </div>
                    </div>
                    
                    <div class="flex gap-2">
                        <button
                            onclick="editVehicle(${vehicle.id})"
                            class="flex-1 bg-blue-50 hover:bg-blue-100 text-blue-700 px-3 py-2 rounded-md transition-colors duration-200 text-sm font-medium"
                        >
                            <i class="fas fa-edit mr-1"></i>Edit
                        </button>
                        <button
                            onclick="deleteVehicle(${vehicle.id})"
                            class="flex-1 bg-red-50 hover:bg-red-100 text-red-700 px-3 py-2 rounded-md transition-colors duration-200 text-sm font-medium"
                        >
                            <i class="fas fa-trash mr-1"></i>Delete
                        </button>
                    </div>
                </div>
            </div>
        `).join('');
    }

    function openCreateModal() {
        isEditing = false;      // We're creating, not editing
        editingId = null;
        document.getElementById('modalTitle').textContent = 'Add Vehicle';
        document.getElementById('submitText').textContent = 'Add Vehicle';
        resetForm(); // Clear form fields
        document.getElementById('vehicleModal').classList.remove('hidden');
    }

    function openEditModal(vehicle) {
        isEditing = true;
        editingId = vehicle.id;
        // Update modal title
        document.getElementById('modalTitle').textContent = 'Edit Vehicle';
        document.getElementById('submitText').textContent = 'Update Vehicle';
        // Fill form with vehicle data
        populateForm(vehicle);
        // Show modal
        document.getElementById('vehicleModal').classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById('vehicleModal').classList.add('hidden');
        resetForm();
    }

    function resetForm() {
        document.getElementById('vehicleForm').reset();
        document.getElementById('vehicleId').value = '';
        document.getElementById('availability').checked = true;
        clearErrors();
    }

    function populateForm(vehicle) {
        document.getElementById('vehicleId').value = vehicle.id;
        document.getElementById('vehicleNumber').value = vehicle.vehicleNumber;
        document.getElementById('type').value = vehicle.type;
        document.getElementById('numOfSeats').value = vehicle.numOfSeats;
        document.getElementById('haveAc').checked = vehicle.haveAc;
        document.getElementById('availability').checked = vehicle.availability;
    }

    function clearErrors() {
        document.querySelectorAll('[id$="Error"]').forEach(error => {
            error.classList.add('hidden');
        });
    }

    async function handleSubmit(e) {
        e.preventDefault(); // Stop form from reloading page

        if (!validateForm()) { // Stop if validation fails
            return;
        }

        const submitBtn = document.getElementById('submitBtn');
        const submitText = document.getElementById('submitText');
        const submitSpinner = document.getElementById('submitSpinner');

        // Show loading state
        submitBtn.disabled = true;
        submitText.classList.add('hidden');
        submitSpinner.classList.remove('hidden');

        // Collect form data
        const formData = {
            vehicleNumber: document.getElementById('vehicleNumber').value.trim(),
            type: document.getElementById('type').value,
            numOfSeats: parseInt(document.getElementById('numOfSeats').value),
            haveAc: document.getElementById('haveAc').checked,
            availability: document.getElementById('availability').checked,
            deleteStatus: false
        };

        try {
            let response;
            if (isEditing) {
                // UPDATE existing vehicle
                response = await fetch(`${API_BASE}/${editingId}`, {
                    method: 'PUT',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                });
            } else {
                response = await fetch(API_BASE, {
                    // CREATE new vehicle
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(formData)
                });
            }

            if (response.ok) {
                closeModal();
                loadVehicles(); // Refresh the list
                showSuccess(isEditing ? 'Vehicle updated successfully' : 'Vehicle added successfully');
            } else {
                const errorData = await response.text();
                showError(errorData);
            }
        } catch (error) {
            showError('Network error: ' + error.message);
        } finally {
            // Hide loading state
            submitBtn.disabled = false;
            submitText.classList.remove('hidden');
            submitSpinner.classList.add('hidden');
        }
    }

    function validateForm() {
        let isValid = true;

        // Vehicle number validation
        const vehicleNumber = document.getElementById('vehicleNumber').value.trim();
        const vehicleNumberError = document.getElementById('vehicleNumberError');
        const vehicleNumberRegex = /^[A-Z]{2,3}-\d{4}$/;

        if (!vehicleNumber || !vehicleNumberRegex.test(vehicleNumber)) {
            vehicleNumberError.classList.remove('hidden');
            isValid = false;
        } else {
            vehicleNumberError.classList.add('hidden');
        }

        // Type validation
        const type = document.getElementById('type').value;
        const typeError = document.getElementById('typeError');

        if (!type) {
            typeError.classList.remove('hidden');
            isValid = false;
        } else {
            typeError.classList.add('hidden');
        }

        // Number of seats validation
        const numOfSeats = document.getElementById('numOfSeats').value;
        const numOfSeatsError = document.getElementById('numOfSeatsError');

        if (!numOfSeats || numOfSeats < 1 || numOfSeats > 50) {
            numOfSeatsError.classList.remove('hidden');
            isValid = false;
        } else {
            numOfSeatsError.classList.add('hidden');
        }

        return isValid;
    }

    function editVehicle(id) {
        // Find the vehicle by ID
        const vehicle = allVehicles.find(v => v.id === id);
        if (vehicle) {
            openEditModal(vehicle);
        }
    }

    function deleteVehicle(id) {
        deleteId = id;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
        deleteId = null;
    }

    async function confirmDelete() {
        if (!deleteId) return;

        const deleteBtn = document.getElementById('confirmDeleteBtn');
        const deleteText = document.getElementById('deleteText');
        const deleteSpinner = document.getElementById('deleteSpinner');

        // Show loading state
        deleteBtn.disabled = true;
        deleteText.classList.add('hidden');
        deleteSpinner.classList.remove('hidden');

        try {
            const response = await fetch(`${API_BASE}/${deleteId}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                closeDeleteModal();
                loadVehicles();
                showSuccess('Vehicle deleted successfully');
            } else {
                const errorData = await response.text();
                showError(errorData);
            }
        } catch (error) {
            showError('Network error: ' + error.message);
        } finally {
            // Hide loading state
            deleteBtn.disabled = false;
            deleteText.classList.remove('hidden');
            deleteSpinner.classList.add('hidden');
        }
    }

    function showLoading() {
        document.getElementById('loadingState').classList.remove('hidden');
        document.getElementById('vehiclesGrid').classList.add('hidden');
        document.getElementById('emptyState').classList.add('hidden');
    }

    function hideLoading() {
        document.getElementById('loadingState').classList.add('hidden');
        document.getElementById('vehiclesGrid').classList.remove('hidden');
    }

    function showSuccess(message) {
        alert(message); // Replace with toast notification if preferred
    }

    function showError(message) {
        alert('Error: ' + message); // Replace with toast notification if preferred
    }

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Make functions globally available
    window.editVehicle = editVehicle;
    window.deleteVehicle = deleteVehicle;
    window.openCreateModal = openCreateModal;
});