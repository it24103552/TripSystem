<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management - Wild Ceylon</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
        }

        .fade-in {
            animation: fadeIn 1s ease-in-out;
        }

        .slide-up {
            animation: slideUp 0.8s ease-out;
        }

        .card-hover {
            transition: all 0.3s ease;
        }

        .card-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        .gradient-text {
            background: linear-gradient(135deg, #10B981, #34D399);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .spinner {
            border: 2px solid #f3f3f3;
            border-top: 2px solid #10B981;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body class="bg-gray-50">

<section class="bg-gradient-to-r from-green-600 to-emerald-700 py-16">
    <div class="container mx-auto px-6">
        <div class="text-center text-white fade-in">
            <h1 class="text-4xl md:text-5xl font-bold mb-4">
                Vehicle <span class="gradient-text">Management</span>
            </h1>
            <p class="text-xl text-green-100 max-w-2xl mx-auto">
                Manage your wildlife tour fleet efficiently
            </p>
        </div>
    </div>
</section>

<div class="container mx-auto px-6 py-8">
    <!-- Controls Section -->
    <div class="bg-white rounded-lg shadow-sm border p-6 mb-6 slide-up">
        <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
            <div class="flex-1 max-w-md">
                <div class="relative">
                    <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-400"></i>
                    <input
                            type="text"
                            id="searchInput"
                            placeholder="Search vehicles..."
                            class="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-green-500 focus:border-transparent"
                    />
                </div>
            </div>
            <button
                    id="addVehicleBtn"
                    class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-md transition-colors duration-200 flex items-center gap-2"
            >
                <i class="fas fa-plus"></i>
                Add Vehicle
            </button>
        </div>
    </div>

    <!-- Loading State -->
    <div id="loadingState" class="hidden">
        <div class="bg-white rounded-lg shadow-sm border p-8 text-center">
            <div class="spinner mx-auto mb-4"></div>
            <p class="text-gray-600">Loading vehicles...</p>
        </div>
    </div>

    <!-- Vehicles Grid -->
    <div id="vehiclesGrid" class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <!-- Vehicle cards will be rendered here -->
    </div>

    <!-- Empty State -->
    <div id="emptyState" class="hidden">
        <div class="bg-white rounded-lg shadow-sm border p-12 text-center">
            <i class="fas fa-car text-gray-400 text-6xl mb-4"></i>
            <h3 class="text-xl font-semibold text-gray-600 mb-2">No vehicles found</h3>
            <p class="text-gray-500 mb-6">Get started by adding your first vehicle to the fleet</p>
            <button
                    class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-md transition-colors duration-200"
                    onclick="openCreateModal()"
            >
                <i class="fas fa-plus mr-2"></i>Add Vehicle
            </button>
        </div>
    </div>
</div>

<!-- Create/Edit Modal -->
<div id="vehicleModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-lg max-w-md w-full max-h-[90vh] overflow-y-auto">
        <div class="p-6">
            <div class="flex justify-between items-center mb-6">
                <h2 id="modalTitle" class="text-xl font-semibold text-gray-900">Add Vehicle</h2>
                <button id="closeModalBtn" class="text-gray-500 hover:text-gray-700">
                    <i class="fas fa-times"></i>
                </button>
            </div>

            <form id="vehicleForm" class="space-y-4">
                <input type="hidden" id="vehicleId" name="vehicleId">

                <div>
                    <label for="vehicleNumber" class="block text-sm font-medium text-gray-700 mb-1">
                        Vehicle Number
                    </label>
                    <input
                            type="text"
                            id="vehicleNumber"
                            name="vehicleNumber"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-green-500 focus:border-transparent"
                            placeholder="ABC-1234"
                    />
                    <span id="vehicleNumberError" class="text-red-500 text-xs hidden">Valid vehicle number required</span>
                </div>

                <div>
                    <label for="type" class="block text-sm font-medium text-gray-700 mb-1">
                        Vehicle Type
                    </label>
                    <select
                            id="type"
                            name="type"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-green-500 focus:border-transparent"
                    >
                        <option value="">Select type</option>
                        <option value="SUV">SUV</option>
                        <option value="Van">Van</option>
                        <option value="Jeep">Jeep</option>
                        <option value="Bus">Bus</option>
                        <option value="Car">Car</option>
                    </select>
                    <span id="typeError" class="text-red-500 text-xs hidden">Vehicle type is required</span>
                </div>

                <div>
                    <label for="numOfSeats" class="block text-sm font-medium text-gray-700 mb-1">
                        Number of Seats
                    </label>
                    <input
                            type="number"
                            id="numOfSeats"
                            name="numOfSeats"
                            min="1"
                            max="50"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:ring-2 focus:ring-green-500 focus:border-transparent"
                            placeholder="4"
                    />
                    <span id="numOfSeatsError" class="text-red-500 text-xs hidden">Number of seats must be between 1 and 50</span>
                </div>

                <div class="flex items-center space-x-2">
                    <input
                            type="checkbox"
                            id="haveAc"
                            name="haveAc"
                            class="rounded border-gray-300 text-green-600 focus:ring-green-500"
                    />
                    <label for="haveAc" class="text-sm font-medium text-gray-700">
                        Air Conditioning
                    </label>
                </div>

                <div class="flex items-center space-x-2">
                    <input
                            type="checkbox"
                            id="availability"
                            name="availability"
                            checked
                            class="rounded border-gray-300 text-green-600 focus:ring-green-500"
                    />
                    <label for="availability" class="text-sm font-medium text-gray-700">
                        Available
                    </label>
                </div>

                <div class="flex gap-3 pt-4">
                    <button
                            type="submit"
                            id="submitBtn"
                            class="flex-1 bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-md transition-colors duration-200 flex items-center justify-center gap-2"
                    >
                        <span id="submitText">Add Vehicle</span>
                        <div id="submitSpinner" class="spinner hidden"></div>
                    </button>
                    <button
                            type="button"
                            id="cancelBtn"
                            class="px-4 py-2 border border-gray-300 text-gray-700 rounded-md hover:bg-gray-50 transition-colors duration-200"
                    >
                        Cancel
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 hidden z-50 flex items-center justify-center p-4">
    <div class="bg-white rounded-lg max-w-sm w-full">
        <div class="p-6">
            <div class="flex items-center mb-4">
                <div class="w-10 h-10 bg-red-100 rounded-full flex items-center justify-center mr-3">
                    <i class="fas fa-trash text-red-600"></i>
                </div>
                <h3 class="text-lg font-semibold text-gray-900">Delete Vehicle</h3>
            </div>
            <p class="text-gray-600 mb-6">
                Are you sure you want to delete this vehicle? This action cannot be undone.
            </p>
            <div class="flex gap-3">
                <button
                        id="confirmDeleteBtn"
                        class="flex-1 bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md transition-colors duration-200 flex items-center justify-center gap-2"
                >
                    <span id="deleteText">Delete</span>
                    <div id="deleteSpinner" class="spinner hidden"></div>
                </button>
                <button
                        id="cancelDeleteBtn"
                        class="px-4 py-2 border border-gray-300 text-gray-700 rounded-md hover:bg-gray-50 transition-colors duration-200"
                >
                    Cancel
                </button>
            </div>
        </div>
    </div>
</div>

<script src="/js/vehicle-management/vehicle-management.js"></script>
</body>
</html>