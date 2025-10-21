<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Management - Wild Ceylon</title>
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

        .star-rating {
            color: #FCD34D;
            text-shadow: 0 1px 2px rgba(0,0,0,0.1);
        }

        .star-empty {
            color: #D1D5DB;
        }
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="../common/navbar.jsp"/>

<!-- Hero Section -->
<section class="bg-gradient-to-r from-green-600 to-emerald-700 py-16">
    <div class="container mx-auto px-6">
        <div class="text-center text-white fade-in">
            <h1 class="text-4xl md:text-5xl font-bold mb-4">
                <span class="gradient-text">Feedback</span> Management
            </h1>
            <p class="text-xl text-green-100 max-w-2xl mx-auto">
                Share your wildlife adventure experiences and help us improve our services
            </p>
        </div>
    </div>
</section>

<div class="container mx-auto px-6 py-12">
    <!-- Create/Update Feedback Form -->
    <div class="bg-white rounded-2xl shadow-xl p-8 mb-8 card-hover slide-up">
        <div class="flex items-center mb-6">
            <div class="w-12 h-12 bg-gradient-to-br from-green-500 to-emerald-600 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-comment-alt text-white text-xl"></i>
            </div>
            <h2 class="text-2xl font-bold text-gray-800" id="formTitle">Create New Feedback</h2>
        </div>

        <form id="feedbackForm">
            <input type="hidden" id="feedbackId" value="">

            <div class="mb-6">
                <label for="title" class="block text-sm font-semibold text-gray-700 mb-3">
                    <i class="fas fa-heading text-green-600 mr-2"></i>Feedback Title
                </label>
                <input type="text" id="title" name="title"
                       class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300"
                       placeholder="Enter a descriptive title for your feedback">
                <span class="text-red-500 text-sm font-medium hidden mt-1" id="titleError">
                    <i class="fas fa-exclamation-triangle mr-1"></i>Title is required and must be at least 3 characters
                </span>
            </div>

            <div class="mb-6">
                <label for="subTitle" class="block text-sm font-semibold text-gray-700 mb-3">
                    <i class="fas fa-align-left text-green-600 mr-2"></i>Detailed Feedback
                </label>
                <textarea id="subTitle" name="subTitle" rows="4"
                          class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300"
                          placeholder="Share your detailed experience with our wildlife tours..."></textarea>
                <span class="text-red-500 text-sm font-medium hidden mt-1" id="subTitleError">
                    <i class="fas fa-exclamation-triangle mr-1"></i>Detailed feedback is required and must be at least 10 characters
                </span>
            </div>

            <div class="mb-8">
                <label for="numOfStars" class="block text-sm font-semibold text-gray-700 mb-3">
                    <i class="fas fa-star text-green-600 mr-2"></i>Rating
                </label>
                <select id="numOfStars" name="numOfStars"
                        class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                    <option value="">Select your rating</option>
                    <option value="1">⭐ 1 Star - Poor</option>
                    <option value="2">⭐⭐ 2 Stars - Fair</option>
                    <option value="3">⭐⭐⭐ 3 Stars - Good</option>
                    <option value="4">⭐⭐⭐⭐ 4 Stars - Very Good</option>
                    <option value="5">⭐⭐⭐⭐⭐ 5 Stars - Excellent</option>
                </select>
                <span class="text-red-500 text-sm font-medium hidden mt-1" id="starsError">
                    <i class="fas fa-exclamation-triangle mr-1"></i>Please select a rating
                </span>
            </div>

            <div class="flex flex-col sm:flex-row gap-4">
                <button type="submit"
                        class="bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-8 py-3 rounded-xl text-lg font-semibold transform hover:scale-105 transition-all duration-300 shadow-lg"
                        id="submitBtn">
                    <i class="fas fa-paper-plane mr-2"></i>Create Feedback
                </button>
                <button type="button"
                        class="bg-gray-500 hover:bg-gray-600 text-white px-8 py-3 rounded-xl text-lg font-semibold transform hover:scale-105 transition-all duration-300 shadow-lg"
                        id="cancelBtn">
                    <i class="fas fa-times mr-2"></i>Cancel
                </button>
            </div>
        </form>
    </div>

    <!-- Feedback List -->
    <div class="bg-white rounded-2xl shadow-xl p-8 bounce-in">
        <div class="flex items-center mb-6">
            <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-list text-white text-xl"></i>
            </div>
            <h2 class="text-2xl font-bold text-gray-800">My Wildlife Feedbacks</h2>
        </div>

        <div id="feedbackList" class="space-y-6">
            <!-- Feedback items will be loaded here -->
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
            <h3 class="text-xl font-bold text-gray-800 mb-2">Delete Feedback</h3>
            <p class="text-gray-600 mb-6">Are you sure you want to delete this feedback? This action cannot be undone.</p>
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

<script src="/js/feedback_management/user_feedback.js"></script>
</body>
</html>