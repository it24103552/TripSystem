<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Wild Ceylon</title>
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

        .bounce-in {
            animation: bounceIn 1.2s ease-out;
        }

        .card-hover {
            transition: all 0.3s ease;
        }

        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.1);
        }

        .gradient-text {
            background: linear-gradient(135deg, #10B981, #34D399);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .pulse-border {
            animation: pulseBorder 2s infinite;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes bounceIn {
            0% { transform: scale(0.3); opacity: 0; }
            50% { transform: scale(1.05); }
            70% { transform: scale(0.9); }
            100% { transform: scale(1); opacity: 1; }
        }

        @keyframes pulseBorder {
            0%, 100% { border-color: #10B981; }
            50% { border-color: #34D399; }
        }

        .status-pending { @apply bg-yellow-100 text-yellow-800; }
        .status-confirmed { @apply bg-green-100 text-green-800; }
        .status-cancelled { @apply bg-red-100 text-red-800; }
        .status-completed { @apply bg-blue-100 text-blue-800; }
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="../common/navbar.jsp"/>

<!-- Hero Section -->
<section class="bg-gradient-to-r from-green-600 to-emerald-700 py-16">
    <div class="container mx-auto px-6">
        <div class="text-center text-white fade-in">
            <h1 class="text-4xl md:text-5xl font-bold mb-4">
                My <span class="gradient-text">Bookings</span>
            </h1>
            <p class="text-xl text-green-100 max-w-2xl mx-auto">
                Track and manage your wildlife adventure bookings
            </p>
        </div>
    </div>
</section>

<div class="container mx-auto px-6 py-12">
    <!-- Booking Stats -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8 slide-up">
        <div class="bg-white rounded-2xl p-6 text-center shadow-lg card-hover">
            <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-3">
                <i class="fas fa-calendar-check text-white text-xl"></i>
            </div>
            <h3 class="text-2xl font-bold text-gray-800" id="totalBookings">0</h3>
            <p class="text-gray-600">Total Bookings</p>
        </div>

        <div class="bg-white rounded-2xl p-6 text-center shadow-lg card-hover">
            <div class="w-12 h-12 bg-gradient-to-br from-yellow-500 to-yellow-600 rounded-full flex items-center justify-center mx-auto mb-3">
                <i class="fas fa-clock text-white text-xl"></i>
            </div>
            <h3 class="text-2xl font-bold text-gray-800" id="pendingBookings">0</h3>
            <p class="text-gray-600">Pending</p>
        </div>

        <div class="bg-white rounded-2xl p-6 text-center shadow-lg card-hover">
            <div class="w-12 h-12 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center mx-auto mb-3">
                <i class="fas fa-check-circle text-white text-xl"></i>
            </div>
            <h3 class="text-2xl font-bold text-gray-800" id="confirmedBookings">0</h3>
            <p class="text-gray-600">Confirmed</p>
        </div>

        <div class="bg-white rounded-2xl p-6 text-center shadow-lg card-hover">
            <div class="w-12 h-12 bg-gradient-to-br from-purple-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-3">
                <i class="fas fa-star text-white text-xl"></i>
            </div>
            <h3 class="text-2xl font-bold text-gray-800" id="completedBookings">0</h3>
            <p class="text-gray-600">Completed</p>
        </div>
    </div>

    <!-- Bookings List -->
    <div class="bg-white rounded-2xl shadow-xl p-8 bounce-in">
        <div class="flex items-center justify-between mb-6">
            <div class="flex items-center">
                <div class="w-12 h-12 bg-gradient-to-br from-indigo-500 to-indigo-600 rounded-full flex items-center justify-center mr-4">
                    <i class="fas fa-list text-white text-xl"></i>
                </div>
                <h2 class="text-2xl font-bold text-gray-800">My Wildlife Adventures</h2>
            </div>

            <div class="flex gap-2">
                <button id="filterAll" class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg font-medium active-filter">
                    All
                </button>
                <button id="filterPending" class="px-4 py-2 bg-gray-100 text-gray-600 rounded-lg font-medium hover:bg-gray-200">
                    Pending
                </button>
                <button id="filterConfirmed" class="px-4 py-2 bg-gray-100 text-gray-600 rounded-lg font-medium hover:bg-gray-200">
                    Confirmed
                </button>
                <button id="filterCompleted" class="px-4 py-2 bg-gray-100 text-gray-600 rounded-lg font-medium hover:bg-gray-200">
                    Completed
                </button>
            </div>
        </div>

        <div id="bookingsList" class="space-y-6">
            <!-- Bookings will be loaded here -->
        </div>
    </div>
</div>

<!-- Cancel Confirmation Modal -->
<div id="cancelModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white p-8 rounded-2xl max-w-md w-full mx-4 shadow-2xl">
        <div class="text-center">
            <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-exclamation-triangle text-yellow-500 text-2xl"></i>
            </div>
            <h3 class="text-xl font-bold text-gray-800 mb-2">Cancel Booking</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to cancel this booking? This action cannot be undone.</p>
            <div class="flex gap-4 justify-center">
                <button id="confirmCancel"
                        class="bg-yellow-500 hover:bg-yellow-600 text-white px-6 py-2 rounded-lg font-semibold transition-colors">
                    <i class="fas fa-times mr-2"></i>Cancel Booking
                </button>
                <button id="cancelCancelAction"
                        class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-2 rounded-lg font-semibold transition-colors">
                    <i class="fas fa-arrow-left mr-2"></i>Keep Booking
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white p-8 rounded-2xl max-w-md w-full mx-4 shadow-2xl">
        <div class="text-center">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-trash-alt text-red-500 text-2xl"></i>
            </div>
            <h3 class="text-xl font-bold text-gray-800 mb-2">Delete Booking</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to delete this booking? This action cannot be undone.</p>
            <div class="flex gap-4 justify-center">
                <button id="confirmDelete"
                        class="bg-red-500 hover:bg-red-600 text-white px-6 py-2 rounded-lg font-semibold transition-colors">
                    <i class="fas fa-trash mr-2"></i>Delete
                </button>
                <button id="cancelDelete"
                        class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-2 rounded-lg font-semibold transition-colors">
                    <i class="fas fa-times mr-2"></i>Cancel
                </button>
            </div>
        </div>
    </div>
</div>

<script src="/js/booking_management/traveler_list.js"></script>
</body>
</html>