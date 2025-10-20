<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Assignments</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
    <script src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
</head>
<body class="min-h-screen bg-gray-50 p-4 md:p-8 font-sans">
<div class="max-w-7xl mx-auto">
    <!-- Header -->
    <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
        <h1 class="text-2xl md:text-3xl font-bold text-gray-800 flex items-center gap-2">
            <i class="fa-solid fa-car-side text-blue-600"></i> Vehicle Assignments
        </h1>
        <div class="flex gap-2">
            <button onclick="history.back()"
                    class="px-3 py-2 bg-gray-600 hover:bg-gray-700 text-white rounded-lg shadow-sm transition-colors flex items-center gap-2">
                <i class="fa-solid fa-arrow-left"></i> <span class="hidden sm:inline">Back</span>
            </button>
            <button id="openModalBtn"
                    class="px-3 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg shadow-sm transition-colors flex items-center gap-2">
                <i class="fa-solid fa-plus"></i> New Assignment
            </button>
        </div>
    </div>

    <!-- Search and Filter -->
    <div class="bg-white rounded-lg shadow-sm p-4 mb-6">
        <div class="flex flex-col md:flex-row gap-4">
            <div class="flex-grow">
                <label for="searchInput" class="block text-sm font-medium text-gray-700 mb-1">Search</label>
                <div class="relative">
                    <input type="text" id="searchInput" placeholder="Search by customer or vehicle..."
                           class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-300 focus:border-blue-500 outline-none transition">
                    <i class="fa-solid fa-search absolute left-3 top-3 text-gray-400"></i>
                </div>
            </div>
            <div class="w-full md:w-1/4">
                <label for="filterSelect" class="block text-sm font-medium text-gray-700 mb-1">Filter by</label>
                <select id="filterSelect" class="w-full py-2 px-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-300 focus:border-blue-500 outline-none transition">
                    <option value="all">All assignments</option>
                    <option value="recent">Recent assignments</option>
                </select>
            </div>
        </div>
    </div>

    <!-- Loading -->
    <div id="loading" class="hidden text-center my-8">
        <div class="inline-block relative w-20 h-20">
            <div class="animate-spin rounded-full h-20 w-20 border-t-4 border-b-4 border-blue-600"></div>
            <i class="fa-solid fa-car-side text-blue-600 text-xl absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2"></i>
        </div>
        <p class="mt-4 text-gray-600">Loading assignments...</p>
    </div>

    <!-- Empty State -->
    <div id="emptyState" class="hidden bg-white rounded-lg shadow-sm p-8 text-center">
        <div class="mx-auto w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mb-4">
            <i class="fa-solid fa-car-side text-gray-400 text-2xl"></i>
        </div>
        <h3 class="text-xl font-medium text-gray-700 mb-2">No Assignments Found</h3>
        <p class="text-gray-500 mb-6">Get started by creating your first vehicle assignment.</p>
        <button id="emptyStateBtn" class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white rounded-lg shadow-sm transition-colors flex items-center gap-2 mx-auto">
            <i class="fa-solid fa-plus"></i> Create Assignment
        </button>
    </div>

    <!-- Table -->
    <div id="tableContainer" class="bg-white rounded-lg shadow-sm overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse" id="assignmentsTable">
                <thead class="bg-gray-50 text-gray-700">
                <tr>
                    <th class="p-3 font-medium">ID</th>
                    <th class="p-3 font-medium">Booking</th>
                    <th class="p-3 font-medium">Customer</th>
                    <th class="p-3 font-medium">Vehicle</th>
                    <th class="p-3 text-center font-medium">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200"></tbody>
            </table>
        </div>
        <!-- Pagination -->
        <div class="flex justify-between items-center p-4 border-t border-gray-200">
            <div class="text-sm text-gray-600">
                Showing <span id="pageInfo">0 items</span>
            </div>
            <div class="flex gap-2">
                <button id="prevPageBtn" class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fa-solid fa-chevron-left"></i>
                </button>
                <button id="nextPageBtn" class="px-3 py-1 rounded border border-gray-300 text-gray-600 hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed">
                    <i class="fa-solid fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Modal -->
<div id="assignmentModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
    <div class="bg-white p-6 rounded-xl shadow-xl w-full max-w-md relative">
        <!-- Close button -->
        <button id="closeModalBtn" class="absolute top-3 right-3 text-gray-500 hover:text-gray-700 transition-colors">
            <i class="fa-solid fa-xmark text-xl"></i>
        </button>

        <h2 id="modalTitle" class="text-xl font-semibold mb-5 text-gray-800 flex items-center gap-2">
            <i class="fa-solid fa-clipboard-list text-green-600"></i> New Assignment
        </h2>

        <form id="assignmentForm" class="space-y-4">
            <input type="hidden" id="assignmentId"/>

            <!-- Booking -->
            <div>
                <label for="bookingId" class="block mb-1 font-medium text-gray-700">Booking</label>
                <div class="relative">
                    <select id="bookingId" class="w-full border border-gray-300 p-2 rounded-lg focus:ring-2 focus:ring-blue-300 focus:border-blue-500 outline-none transition">
                        <option value="">Select Booking</option>
                    </select>
                    <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                        <i id="bookingLoadingIcon" class="fa-solid fa-spinner fa-spin text-gray-400 hidden"></i>
                    </div>
                </div>
                <p id="bookingError" class="text-red-600 text-sm hidden mt-1">
                    <i class="fa-solid fa-circle-exclamation"></i> Please select a valid booking
                </p>
                <p id="bookingInfo" class="text-sm text-gray-600 mt-1 hidden"></p>
            </div>

            <!-- Vehicle -->
            <div>
                <label for="vehicleId" class="block mb-1 font-medium text-gray-700">Vehicle</label>
                <div class="relative">
                    <select id="vehicleId" class="w-full border border-gray-300 p-2 rounded-lg focus:ring-2 focus:ring-blue-300 focus:border-blue-500 outline-none transition">
                        <option value="">Select Vehicle</option>
                    </select>
                    <div class="absolute inset-y-0 right-0 flex items-center pr-3 pointer-events-none">
                        <i id="vehicleLoadingIcon" class="fa-solid fa-spinner fa-spin text-gray-400 hidden"></i>
                    </div>
                </div>
                <p id="vehicleError" class="text-red-600 text-sm hidden mt-1">
                    <i class="fa-solid fa-circle-exclamation"></i> Please select a valid vehicle
                </p>
                <p id="vehicleInfo" class="text-sm text-gray-600 mt-1 hidden"></p>
            </div>

            <!-- Actions -->
            <div class="flex justify-end gap-2 pt-4">
                <button type="button" id="cancelBtn"
                        class="px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-lg transition-colors">
                    Cancel
                </button>
                <button type="submit" id="saveBtn"
                        class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white rounded-lg shadow-sm transition-colors flex items-center gap-2">
                    <i class="fa-solid fa-check"></i> Save
                    <i id="saveLoadingIcon" class="fa-solid fa-spinner fa-spin ml-1 hidden"></i>
                </button>
            </div>
        </form>
    </div>
</div>

<!-- Confirmation Modal -->
<div id="confirmationModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
    <div class="bg-white p-6 rounded-xl shadow-xl w-full max-w-sm relative">
        <h3 class="text-lg font-semibold mb-3 text-gray-800">Confirm Deletion</h3>
        <p class="text-gray-600 mb-5">Are you sure you want to delete this assignment? This action cannot be undone.</p>

        <div class="flex justify-end gap-3">
            <button id="cancelDeleteBtn" class="px-4 py-2 bg-gray-200 hover:bg-gray-300 text-gray-800 rounded-lg transition-colors">
                Cancel
            </button>
            <button id="confirmDeleteBtn" class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white rounded-lg shadow-sm transition-colors flex items-center">
                <i class="fa-solid fa-trash mr-2"></i> Delete
                <i id="deleteLoadingIcon" class="fa-solid fa-spinner fa-spin ml-2 hidden"></i>
            </button>
        </div>
    </div>
</div>

<script src="/js/vehicle-assignments/vehicle-assignments.js"></script>
</body>
</html>
