<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Your Wildlife Adventure - Wild Ceylon</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
        }

        .gradient-bg {
            background: linear-gradient(135deg, rgba(16,185,129,0.1) 0%, rgba(52,211,153,0.1) 100%);
        }

        .form-input {
            transition: all 0.3s ease;
            border: 2px solid #e5e7eb;
        }

        .form-input:focus {
            border-color: #10b981;
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
            outline: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #10b981, #34d399);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #059669, #10b981);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
        }

        .loading {
            display: none;
        }

        .loading.show {
            display: inline-block;
        }

        .error {
            background-color: #fee2e2;
            border-color: #fca5a5;
            color: #991b1b;
        }

        .success {
            background-color: #dcfce7;
            border-color: #86efac;
            color: #166534;
        }

        .fade-in {
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
<!-- Include Navbar -->
<jsp:include page="../common/navbar.jsp"/>

<div class="gradient-bg min-h-screen py-12">
    <div class="container mx-auto px-6">
        <!-- Header -->
        <div class="text-center mb-12 fade-in">
            <h1 class="text-4xl md:text-5xl font-bold text-gray-800 mb-4">
                Book Your <span class="bg-gradient-to-r from-green-500 to-emerald-600 bg-clip-text text-transparent">Wildlife Adventure</span>
            </h1>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
                Complete your booking details and get ready for an unforgettable experience
            </p>
        </div>

        <!-- Booking Form -->
        <div class="max-w-4xl mx-auto">
            <div class="bg-white rounded-3xl shadow-2xl overflow-hidden fade-in">
                <!-- Selected Package Info -->
                <div class="bg-gradient-to-r from-green-500 to-emerald-600 p-8 text-white">
                    <div class="flex items-center justify-between">
                        <div>
                            <h2 class="text-3xl font-bold mb-2" id="packageName">Loading...</h2>
                            <p class="text-green-100 text-lg">Selected Wildlife Destination</p>
                        </div>
                        <div class="text-right">
                            <p class="text-green-100 text-lg">Total Price</p>
                            <p class="text-4xl font-bold" id="packagePrice">LKR 0</p>
                            <p class="text-green-100">per person</p>
                        </div>
                    </div>
                </div>

                <!-- Form Content -->
                <div class="p-8">
                    <!-- Alert Messages -->
                    <div id="alertMessage" class="hidden mb-6 p-4 rounded-lg border"></div>

                    <!-- User Info Section -->
                    <div class="mb-8">
                        <h3 class="text-2xl font-bold text-gray-800 mb-4 flex items-center">
                            <i class="fas fa-user-circle text-green-500 mr-3"></i>
                            Customer Information
                        </h3>
                        <div class="bg-gray-50 p-6 rounded-xl" id="customerInfo">
                            <div class="flex items-center justify-center py-8">
                                <i class="fas fa-spinner fa-spin text-2xl text-gray-400 mr-3"></i>
                                <span class="text-gray-500">Loading customer information...</span>
                            </div>
                        </div>
                    </div>

                    <!-- Booking Form -->
                    <form id="bookingForm" class="space-y-6">
                        <!-- Booking Date -->
                        <div>
                            <label for="bookingDate" class="block text-lg font-semibold text-gray-700 mb-3">
                                <i class="fas fa-calendar-alt text-green-500 mr-2"></i>
                                Select Your Adventure Date
                            </label>
                            <input type="date"
                                   id="bookingDate"
                                   name="bookingDate"
                                   required
                                   class="form-input w-full px-4 py-3 rounded-xl text-lg"
                                   min="">
                        </div>

                        <!-- Number of People -->
                        <div>
                            <label for="numberOfPeople" class="block text-lg font-semibold text-gray-700 mb-3">
                                <i class="fas fa-users text-green-500 mr-2"></i>
                                Number of People
                            </label>
                            <select id="numberOfPeople"
                                    name="numberOfPeople"
                                    required
                                    class="form-input w-full px-4 py-3 rounded-xl text-lg">
                                <option value="">Select number of people</option>
                                <option value="1">1 Person</option>
                                <option value="2">2 People</option>
                                <option value="3">3 People</option>
                                <option value="4">4 People</option>
                                <option value="5">5 People</option>
                                <option value="6">6 People</option>
                                <option value="7">7 People</option>
                                <option value="8">8 People</option>
                                <option value="9">9 People</option>
                                <option value="10">10+ People</option>
                            </select>
                        </div>

                        <!-- Additional Notes -->
                        <div>
                            <label for="additionalNotes" class="block text-lg font-semibold text-gray-700 mb-3">
                                <i class="fas fa-sticky-note text-green-500 mr-2"></i>
                                Additional Notes & Special Requests
                            </label>
                            <textarea id="additionalNotes"
                                      name="additionalNotes"
                                      rows="4"
                                      placeholder="Any special requirements, dietary restrictions, or additional information you'd like to share..."
                                      class="form-input w-full px-4 py-3 rounded-xl text-lg resize-none"></textarea>
                        </div>

                        <!-- Total Bill Display -->
                        <div class="bg-gradient-to-r from-green-50 to-emerald-50 p-6 rounded-xl border-2 border-green-200">
                            <div class="flex items-center justify-between text-2xl font-bold">
                                <span class="text-gray-700">Total Amount:</span>
                                <span class="text-green-600" id="totalBill">LKR 0</span>
                            </div>
                            <p class="text-green-600 mt-2">
                                <i class="fas fa-info-circle mr-1"></i>
                                Final amount will be calculated based on selected date and number of people
                            </p>
                        </div>

                        <!-- Submit Button -->
                        <div class="pt-6">
                            <button type="submit"
                                    id="submitBtn"
                                    class="btn-primary w-full py-4 px-8 text-white text-xl font-bold rounded-xl disabled:opacity-50 disabled:cursor-not-allowed">
                                    <span id="submitText">
                                        <i class="fas fa-paw mr-2"></i>
                                        Confirm Booking & Proceed to Payment
                                    </span>
                                <span id="loadingText" class="loading">
                                        <i class="fas fa-spinner fa-spin mr-2"></i>
                                        Processing Your Booking...
                                    </span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include the booking management JavaScript -->
<script src="/js/booking_management/create.js"></script>
</body>
</html>