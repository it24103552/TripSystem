<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Wild Ceylon</title>
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
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="../common/navbar.jsp"/>

<section class="bg-gradient-to-r from-green-600 to-emerald-700 py-16">
    <div class="container mx-auto px-6">
        <div class="text-center text-white fade-in">
            <h1 class="text-4xl md:text-5xl font-bold mb-4">
                My <span class="gradient-text">Profile</span>
            </h1>
            <p class="text-xl text-green-100 max-w-2xl mx-auto">
                Manage your account information and preferences
            </p>
        </div>
    </div>
</section>

<div class="container mx-auto px-6 py-12">
    <div class="bg-white rounded-2xl shadow-xl p-8 slide-up">
        <form id="profileForm">
            <div class="grid md:grid-cols-2 gap-6">
                <div class="mb-4">
                    <label for="firstName" class="block text-sm font-semibold text-gray-700 mb-3">
                        <i class="fas fa-user text-green-600 mr-2"></i>First Name
                    </label>
                    <input type="text" id="firstName" name="firstName"
                           class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                    <span class="text-red-500 text-sm font-medium hidden mt-1" id="firstNameError">
                        <i class="fas fa-exclamation-triangle mr-1"></i>First name is required and must be at least 2 characters
                    </span>
                </div>

                <div class="mb-4">
                    <label for="lastName" class="block text-sm font-semibold text-gray-700 mb-3">
                        <i class="fas fa-user text-green-600 mr-2"></i>Last Name
                    </label>
                    <input type="text" id="lastName" name="lastName"
                           class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                    <span class="text-red-500 text-sm font-medium hidden mt-1" id="lastNameError">
                        <i class="fas fa-exclamation-triangle mr-1"></i>Last name is required and must be at least 2 characters
                    </span>
                </div>

                <div class="mb-4">
                    <label for="email" class="block text-sm font-semibold text-gray-700 mb-3">
                        <i class="fas fa-envelope text-green-600 mr-2"></i>Email Address
                    </label>
                    <input type="email" id="email" name="email"
                           class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                    <span class="text-red-500 text-sm font-medium hidden mt-1" id="emailError">
                        <i class="fas fa-exclamation-triangle mr-1"></i>Please enter a valid email address
                    </span>
                </div>

                <div class="mb-4">
                    <label for="phoneNumber" class="block text-sm font-semibold text-gray-700 mb-3">
                        <i class="fas fa-phone text-green-600 mr-2"></i>Phone Number
                    </label>
                    <input type="text" id="phoneNumber" name="phoneNumber"
                           class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                    <span class="text-red-500 text-sm font-medium hidden mt-1" id="phoneNumberError">
                        <i class="fas fa-exclamation-triangle mr-1"></i>Please enter a valid phone number
                    </span>
                </div>

                <div class="mb-4">
                    <label for="country" class="block text-sm font-semibold text-gray-700 mb-3">
                        <i class="fas fa-globe text-green-600 mr-2"></i>Country
                    </label>
                    <input type="text" id="country" name="country"
                           class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                    <span class="text-red-500 text-sm font-medium hidden mt-1" id="countryError">
                        <i class="fas fa-exclamation-triangle mr-1"></i>Country is required
                    </span>
                </div>


            </div>

            <div class="flex flex-col sm:flex-row gap-4 mt-8">
                <button type="submit"
                        class="bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-8 py-3 rounded-xl text-lg font-semibold transform hover:scale-105 transition-all duration-300 shadow-lg">
                    <i class="fas fa-save mr-2"></i>Update Profile
                </button>

                <button type="button" id="deleteBtn"
                        class="bg-red-500 hover:bg-red-600 text-white px-8 py-3 rounded-xl text-lg font-semibold transform hover:scale-105 transition-all duration-300 shadow-lg">
                    <i class="fas fa-trash mr-2"></i>Delete Account
                </button>

                <button type="button" id="logoutBtn"
                        class="bg-gray-500 hover:bg-gray-600 text-white px-8 py-3 rounded-xl text-lg font-semibold transform hover:scale-105 transition-all duration-300 shadow-lg">
                    <i class="fas fa-sign-out-alt mr-2"></i>Logout
                </button>
            </div>
        </form>
    </div>
</div>

<div id="deleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center hidden z-50">
    <div class="bg-white p-8 rounded-2xl max-w-md w-full mx-4 shadow-2xl">
        <div class="text-center">
            <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <i class="fas fa-exclamation-triangle text-red-500 text-2xl"></i>
            </div>
            <h3 class="text-xl font-bold text-gray-800 mb-2">Delete Account</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to delete your account? This action cannot be undone.</p>
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

<script src="/js/user_management/profile.js"></script>
</body>
</html>