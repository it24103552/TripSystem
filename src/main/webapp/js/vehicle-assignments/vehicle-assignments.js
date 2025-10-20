/**
 * Vehicle Assignments Management
 * Handles CRUD operations for vehicle assignments
 */
document.addEventListener("DOMContentLoaded", () => {
    // DOM Elements
    const elements = {
        // Containers
        modal: document.getElementById("assignmentModal"),
        confirmModal: document.getElementById("confirmationModal"),
        tableContainer: document.getElementById("tableContainer"),
        emptyState: document.getElementById("emptyState"),
        loading: document.getElementById("loading"),

        // Form elements
        form: document.getElementById("assignmentForm"),
        modalTitle: document.getElementById("modalTitle"),
        bookingSelect: document.getElementById("bookingId"),
        vehicleSelect: document.getElementById("vehicleId"),
        bookingError: document.getElementById("bookingError"),
        vehicleError: document.getElementById("vehicleError"),
        idField: document.getElementById("assignmentId"),
        tableBody: document.querySelector("#assignmentsTable tbody"),

        // Buttons
        openBtn: document.getElementById("openModalBtn"),
        closeBtn: document.getElementById("closeModalBtn"),
        cancelBtn: document.getElementById("cancelBtn"),
        emptyStateBtn: document.getElementById("emptyStateBtn"),
        saveBtn: document.getElementById("saveBtn"),
        prevPageBtn: document.getElementById("prevPageBtn"),
        nextPageBtn: document.getElementById("nextPageBtn"),

        // Confirmation modal buttons
        cancelDeleteBtn: document.getElementById("cancelDeleteBtn"),
        confirmDeleteBtn: document.getElementById("confirmDeleteBtn"),

        // Loading indicators
        saveLoadingIcon: document.getElementById("saveLoadingIcon"),
        deleteLoadingIcon: document.getElementById("deleteLoadingIcon"),
        bookingLoadingIcon: document.getElementById("bookingLoadingIcon"),
        vehicleLoadingIcon: document.getElementById("vehicleLoadingIcon"),

        // Info elements
        bookingInfo: document.getElementById("bookingInfo"),
        vehicleInfo: document.getElementById("vehicleInfo"),
        pageInfo: document.getElementById("pageInfo"),

        // Search and filter
        searchInput: document.getElementById("searchInput"),
        filterSelect: document.getElementById("filterSelect")
    };

    // API endpoints
    const API = {
        ASSIGNMENTS: "/api/vehicle-assignments",
        BOOKINGS: "/api/bookings",
        VEHICLES: "/api/vehicles/available"
    };

    // Validation patterns
    const PATTERNS = {
        NUMBER: /^[0-9]+$/
    };

    // State management
    const state = {
        assignments: [],
        filteredAssignments: [],
        bookings: [],
        vehicles: [],
        currentPage: 1,
        itemsPerPage: 10,
        currentItemToDelete: null,
        searchTerm: "",
        filterBy: "all"
    };

    /**
     * UI Utility Functions
     */
    const ui = {
        toggleLoading: (show) => {
            elements.loading.classList.toggle("hidden", !show);
        },

        toggleEmptyState: (show) => {
            elements.emptyState.classList.toggle("hidden", !show);
            elements.tableContainer.classList.toggle("hidden", show);
        },

        openModal: (edit = false, data = {}) => {
            elements.modal.classList.remove("hidden");
            elements.modalTitle.innerHTML = edit
                ? '<i class="fa-solid fa-edit text-blue-600"></i> Edit Assignment'
                : '<i class="fa-solid fa-plus text-green-600"></i> New Assignment';
            elements.idField.value = data.id || "";
            elements.bookingSelect.value = data.bookingId || "";
            elements.vehicleSelect.value = data.vehicleId || "";

            // Clear previous errors and info
            elements.bookingError.classList.add("hidden");
            elements.vehicleError.classList.add("hidden");
            elements.bookingInfo.classList.add("hidden");
            elements.vehicleInfo.classList.add("hidden");

            // Show booking and vehicle details if editing
            if (edit && data.bookingId) {
                ui.updateBookingInfo(data.bookingId);
            }
            if (edit && data.vehicleId) {
                ui.updateVehicleInfo(data.vehicleId);
            }

            // Add animation class
            setTimeout(() => {
                document.querySelector("#assignmentModal > div").classList.add("scale-100");
            }, 10);
        },

        closeModal: () => {
            document.querySelector("#assignmentModal > div").classList.remove("scale-100");
            setTimeout(() => {
                elements.modal.classList.add("hidden");
            }, 200);
            elements.form.reset();
        },

        openConfirmModal: (id) => {
            state.currentItemToDelete = id;
            elements.confirmModal.classList.remove("hidden");
        },

        closeConfirmModal: () => {
            elements.confirmModal.classList.add("hidden");
            state.currentItemToDelete = null;
        },

        showToast: (message, success = true) => {
            Toastify({
                text: message,
                duration: 3000,
                gravity: "top",
                position: "right",
                style: {
                    background: success ? "#10B981" : "#EF4444",
                    borderRadius: "8px",
                    padding: "12px 20px"
                }
            }).showToast();
        },

        updateBookingInfo: (bookingId) => {
            const booking = state.bookings.find(b => b.id === parseInt(bookingId));
            if (booking) {
                elements.bookingInfo.textContent = `${booking.customerName} • ${new Date(booking.bookingDate).toLocaleDateString()}`;
                elements.bookingInfo.classList.remove("hidden");
            } else {
                elements.bookingInfo.classList.add("hidden");
            }
        },

        updateVehicleInfo: (vehicleId) => {
            const vehicle = state.vehicles.find(v => v.id === parseInt(vehicleId));
            if (vehicle) {
                elements.vehicleInfo.textContent = `${vehicle.vehicleNumber} • ${vehicle.type}`;
                elements.vehicleInfo.classList.remove("hidden");
            } else {
                elements.vehicleInfo.classList.add("hidden");
            }
        },

        toggleSaveLoading: (show) => {
            elements.saveLoadingIcon.classList.toggle("hidden", !show);
            elements.saveBtn.disabled = show;
        },

        toggleDeleteLoading: (show) => {
            elements.deleteLoadingIcon.classList.toggle("hidden", !show);
            elements.confirmDeleteBtn.disabled = show;
        },

        toggleBookingLoading: (show) => {
            elements.bookingLoadingIcon.classList.toggle("hidden", !show);
        },

        toggleVehicleLoading: (show) => {
            elements.vehicleLoadingIcon.classList.toggle("hidden", !show);
        },

        updatePagination: () => {
            const totalItems = state.filteredAssignments.length;
            const totalPages = Math.ceil(totalItems / state.itemsPerPage);
            const startItem = (state.currentPage - 1) * state.itemsPerPage + 1;
            const endItem = Math.min(state.currentPage * state.itemsPerPage, totalItems);

            elements.pageInfo.textContent = totalItems > 0
                ? `${startItem}-${endItem} of ${totalItems} items`
                : `0 items`;

            elements.prevPageBtn.disabled = state.currentPage <= 1;
            elements.nextPageBtn.disabled = state.currentPage >= totalPages;
        }
    };

    /**
     * Data Fetching Functions
     */
    const api = {
        fetchAssignments: async () => {
            try {
                ui.toggleLoading(true);
                const response = await fetch(API.ASSIGNMENTS);
                if (!response.ok) throw new Error("Failed to fetch assignments");
                const data = await response.json();

                state.assignments = data;
                state.filteredAssignments = [...data];
                ui.toggleEmptyState(data.length === 0);

                return data;
            } catch (error) {
                console.error("Error fetching assignments:", error);
                ui.showToast("Failed to load assignments", false);
                return [];
            } finally {
                ui.toggleLoading(false);
            }
        },

        fetchBookings: async () => {
            try {
                ui.toggleBookingLoading(true);
                const response = await fetch(API.BOOKINGS);
                if (!response.ok) throw new Error("Failed to fetch bookings");
                const data = await response.json();

                state.bookings = data;

                // Clear and populate dropdown
                elements.bookingSelect.innerHTML = '<option value="">Select Booking</option>';
                data.forEach(booking => {
                    const option = document.createElement("option");
                    option.value = booking.id;
                    option.textContent = `${booking.customerName} - ${new Date(booking.bookingDate).toLocaleDateString()}`;
                    elements.bookingSelect.appendChild(option);
                });

                return data;
            } catch (error) {
                console.error("Error fetching bookings:", error);
                ui.showToast("Failed to load bookings", false);
                return [];
            } finally {
                ui.toggleBookingLoading(false);
            }
        },

        fetchVehicles: async () => {
            try {
                ui.toggleVehicleLoading(true);
                const response = await fetch(API.VEHICLES);
                if (!response.ok) throw new Error("Failed to fetch vehicles");
                const data = await response.json();

                state.vehicles = data;

                // Clear and populate dropdown
                elements.vehicleSelect.innerHTML = '<option value="">Select Vehicle</option>';
                data.forEach(vehicle => {
                    const option = document.createElement("option");
                    option.value = vehicle.id;
                    option.textContent = `${vehicle.vehicleNumber} (${vehicle.type})`;
                    elements.vehicleSelect.appendChild(option);
                });

                return data;
            } catch (error) {
                console.error("Error fetching vehicles:", error);
                ui.showToast("Failed to load vehicles", false);
                return [];
            } finally {
                ui.toggleVehicleLoading(false);
            }
        },

        saveAssignment: async (payload, id = null) => {
            try {
                ui.toggleSaveLoading(true);

                const method = id ? "PUT" : "POST";
                const url = id ? `${API.ASSIGNMENTS}/${id}` : API.ASSIGNMENTS;

                const response = await fetch(url, {
                    method,
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(payload)
                });

                if (!response.ok) throw new Error("Failed to save assignment");

                ui.showToast(`Assignment ${id ? 'updated' : 'created'} successfully`);
                ui.closeModal();
                await api.fetchAssignments();
                renderAssignments();

                return true;
            } catch (error) {
                console.error("Error saving assignment:", error);
                ui.showToast("Failed to save assignment", false);
                return false;
            } finally {
                ui.toggleSaveLoading(false);
            }
        },

        deleteAssignment: async (id) => {
            try {
                ui.toggleDeleteLoading(true);

                const response = await fetch(`${API.ASSIGNMENTS}/${id}`, {
                    method: "DELETE"
                });

                if (!response.ok) throw new Error("Failed to delete assignment");

                ui.showToast("Assignment deleted successfully");
                ui.closeConfirmModal();
                await api.fetchAssignments();
                renderAssignments();

                return true;
            } catch (error) {
                console.error("Error deleting assignment:", error);
                ui.showToast("Failed to delete assignment", false);
                return false;
            } finally {
                ui.toggleDeleteLoading(false);
            }
        }
    };

    /**
     * Render the assignments table with current data
     */
    const renderAssignments = () => {
        elements.tableBody.innerHTML = "";

        // Get current page items
        const startIndex = (state.currentPage - 1) * state.itemsPerPage;
        const endIndex = startIndex + state.itemsPerPage;
        const currentItems = state.filteredAssignments.slice(startIndex, endIndex);

        if (currentItems.length === 0) {
            ui.toggleEmptyState(true);
            return;
        }

        ui.toggleEmptyState(false);

        currentItems.forEach(assignment => {
            const row = document.createElement("tr");
            row.className = "hover:bg-gray-50 transition-colors";

            row.innerHTML = `
                <td class="p-3 text-gray-800">${assignment.id}</td>
                <td class="p-3 text-gray-800">
                    <div class="font-medium">${assignment.bookingId}</div>
                    <div class="text-sm text-gray-500">
                        ${new Date(assignment.bookingDate || Date.now()).toLocaleDateString()}
                    </div>
                </td>
                <td class="p-3">
                    <div class="font-medium text-gray-800">${assignment.customerName}</div>
                    <div class="text-sm text-gray-500">${assignment.customerEmail}</div>
                </td>
                <td class="p-3">
                    <div class="flex items-center">
                        <span class="w-3 h-3 rounded-full bg-green-500 mr-2"></span>
                        <div>
                            <div class="font-medium text-gray-800">${assignment.vehicleNumber}</div>
                            <div class="text-sm text-gray-500">${assignment.vehicleType}</div>
                        </div>
                    </div>
                </td>
                <td class="p-3 text-center">
                    <div class="flex justify-center gap-2">
                        <button class="p-1.5 rounded-lg bg-blue-50 text-blue-600 hover:bg-blue-100 transition-colors" 
                                data-action="edit" data-id="${assignment.id}">
                            <i class="fa-solid fa-pen-to-square"></i>
                        </button>
                        <button class="p-1.5 rounded-lg bg-red-50 text-red-600 hover:bg-red-100 transition-colors" 
                                data-action="delete" data-id="${assignment.id}">
                            <i class="fa-solid fa-trash"></i>
                        </button>
                    </div>
                </td>
            `;

            elements.tableBody.appendChild(row);
        });

        ui.updatePagination();
    };

    /**
     * Filter assignments based on search term and filter option
     */
    const filterAssignments = () => {
        const searchTerm = state.searchTerm.toLowerCase().trim();
        const filterBy = state.filterBy;

        if (!searchTerm && filterBy === "all") {
            state.filteredAssignments = [...state.assignments];
        } else {
            state.filteredAssignments = state.assignments.filter(assignment => {
                // Search filter
                const matchesSearch = !searchTerm ||
                    assignment.customerName?.toLowerCase().includes(searchTerm) ||
                    assignment.customerEmail?.toLowerCase().includes(searchTerm) ||
                    assignment.vehicleNumber?.toLowerCase().includes(searchTerm) ||
                    assignment.vehicleType?.toLowerCase().includes(searchTerm);

                // Type filter
                let matchesFilter = true;
                if (filterBy === "recent") {
                    // Filter for assignments created in the last 7 days
                    const sevenDaysAgo = new Date();
                    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
                    matchesFilter = new Date(assignment.createdAt || Date.now()) >= sevenDaysAgo;
                }

                return matchesSearch && matchesFilter;
            });
        }

        // Reset to first page when filtering changes
        state.currentPage = 1;
        renderAssignments();
    };

    /**
     * Validate form data
     */
    const validateForm = () => {
        let isValid = true;

        // Validate booking
        if (!PATTERNS.NUMBER.test(elements.bookingSelect.value)) {
            elements.bookingError.classList.remove("hidden");
            isValid = false;
        } else {
            elements.bookingError.classList.add("hidden");
        }

        // Validate vehicle
        if (!PATTERNS.NUMBER.test(elements.vehicleSelect.value)) {
            elements.vehicleError.classList.remove("hidden");
            isValid = false;
        } else {
            elements.vehicleError.classList.add("hidden");
        }

        return isValid;
    };

    /**
     * Handle form submission
     */
    const handleFormSubmit = async (e) => {
        e.preventDefault();

        if (!validateForm()) return;

        const payload = {
            bookingId: parseInt(elements.bookingSelect.value),
            vehicleId: parseInt(elements.vehicleSelect.value)
        };

        const id = elements.idField.value;
        await api.saveAssignment(payload, id || null);
    };

    /**
     * Handle edit assignment action
     */
    const handleEditAssignment = (id) => {
        const assignment = state.assignments.find(a => a.id === parseInt(id));
        if (assignment) {
            ui.openModal(true, assignment);
        }
    };

    /**
     * Handle delete assignment action
     */
    const handleDeleteAssignment = (id) => {
        ui.openConfirmModal(id);
    };

    /**
     * Initialize the application
     */
    const init = async () => {
        // Fetch initial data
        await Promise.all([
            api.fetchAssignments(),
            api.fetchBookings(),
            api.fetchVehicles()
        ]);

        renderAssignments();

        // Event listeners for form actions
        elements.form.addEventListener("submit", handleFormSubmit);
        elements.openBtn.addEventListener("click", () => ui.openModal());
        elements.closeBtn.addEventListener("click", ui.closeModal);
        elements.cancelBtn.addEventListener("click", ui.closeModal);
        elements.emptyStateBtn.addEventListener("click", () => ui.openModal());

        // Event listeners for confirmation modal
        elements.cancelDeleteBtn.addEventListener("click", ui.closeConfirmModal);
        elements.confirmDeleteBtn.addEventListener("click", async () => {
            if (state.currentItemToDelete) {
                await api.deleteAssignment(state.currentItemToDelete);
            }
        });

        // Event listeners for table actions
        elements.tableBody.addEventListener("click", (e) => {
            const button = e.target.closest("[data-action]");
            if (!button) return;

            const action = button.dataset.action;
            const id = parseInt(button.dataset.id);

            if (action === "edit") {
                handleEditAssignment(id);
            } else if (action === "delete") {
                handleDeleteAssignment(id);
            }
        });

        // Event listeners for pagination
        elements.prevPageBtn.addEventListener("click", () => {
            if (state.currentPage > 1) {
                state.currentPage--;
                renderAssignments();
            }
        });

        elements.nextPageBtn.addEventListener("click", () => {
            const totalPages = Math.ceil(state.filteredAssignments.length / state.itemsPerPage);
            if (state.currentPage < totalPages) {
                state.currentPage++;
                renderAssignments();
            }
        });

        // Event listeners for search and filter
        elements.searchInput.addEventListener("input", (e) => {
            state.searchTerm = e.target.value;
            filterAssignments();
        });

        elements.filterSelect.addEventListener("change", (e) => {
            state.filterBy = e.target.value;
            filterAssignments();
        });

        // Event listeners for select changes to show additional info
        elements.bookingSelect.addEventListener("change", (e) => {
            ui.updateBookingInfo(e.target.value);
        });

        elements.vehicleSelect.addEventListener("change", (e) => {
            ui.updateVehicleInfo(e.target.value);
        });
    };

    // Start the application
    init();
});