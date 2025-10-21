<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Payment - Wild Ceylon</title>
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

        .payment-card {
            background: linear-gradient(135deg, #1e293b, #334155);
            border-radius: 20px;
            color: white;
            padding: 24px;
            transform-style: preserve-3d;
            transition: all 0.6s ease;
        }

        .payment-card.flipped {
            transform: rotateY(180deg);
        }

        .card-front, .card-back {
            backface-visibility: hidden;
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            padding: 24px;
            border-radius: 20px;
        }

        .card-back {
            background: linear-gradient(135deg, #334155, #1e293b);
            transform: rotateY(180deg);
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

        .payment-method {
            cursor: pointer;
            transition: all 0.3s ease;
            border: 2px solid #e5e7eb;
        }

        .payment-method:hover {
            border-color: #10b981;
            transform: translateY(-2px);
        }

        .payment-method.selected {
            border-color: #10b981;
            background-color: rgba(16, 185, 129, 0.1);
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

        .slide-up {
            animation: slideUp 0.8s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        .card-type-icon {
            width: 40px;
            height: 25px;
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
                Complete Your <span class="bg-gradient-to-r from-green-500 to-emerald-600 bg-clip-text text-transparent">Payment</span>
            </h1>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
                Secure payment processing for your wildlife adventure
            </p>
        </div>

        <!-- Payment Container -->
        <div class="max-w-6xl mx-auto">
            <div class="grid lg:grid-cols-2 gap-8">
                <!-- Payment Form -->
                <div class="bg-white rounded-3xl shadow-2xl p-8 slide-up">
                    <!-- Alert Messages -->
                    <div id="alertMessage" class="hidden mb-6 p-4 rounded-lg border"></div>

                    <!-- Booking Summary -->
                    <div class="mb-8">
                        <h2 class="text-2xl font-bold text-gray-800 mb-4 flex items-center">
                            <i class="fas fa-file-invoice-dollar text-green-500 mr-3"></i>
                            Booking Summary
                        </h2>
                        <div class="bg-gray-50 p-6 rounded-xl" id="bookingSummary">
                            <div class="flex items-center justify-center py-8">
                                <i class="fas fa-spinner fa-spin text-2xl text-gray-400 mr-3"></i>
                                <span class="text-gray-500">Loading booking details...</span>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Methods -->
                    <div class="mb-8">
                        <h2 class="text-2xl font-bold text-gray-800 mb-4 flex items-center">
                            <i class="fas fa-credit-card text-green-500 mr-3"></i>
                            Select Payment Method
                        </h2>
                        <div class="grid md:grid-cols-3 gap-4">
                            <div class="payment-method p-4 rounded-xl text-center" data-method="CARD">
                                <i class="fas fa-credit-card text-3xl text-blue-500 mb-2"></i>
                                <p class="font-semibold">Credit/Debit Card</p>
                            </div>
                            <div class="payment-method p-4 rounded-xl text-center" data-method="BANK_TRANSFER">
                                <i class="fas fa-university text-3xl text-purple-500 mb-2"></i>
                                <p class="font-semibold">Bank Transfer</p>
                            </div>
                            <div class="payment-method p-4 rounded-xl text-center" data-method="CASH">
                                <i class="fas fa-money-bill-wave text-3xl text-green-500 mb-2"></i>
                                <p class="font-semibold">Cash Payment</p>
                            </div>
                        </div>
                    </div>

                    <!-- Card Payment Form -->
                    <div id="cardPaymentForm" class="hidden">
                        <h3 class="text-xl font-bold text-gray-800 mb-4">Card Payment Details</h3>
                        <form id="paymentForm" class="space-y-6">
                            <div>
                                <label for="cardNumber" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Card Number
                                </label>
                                <div class="relative">
                                    <input type="text"
                                           id="cardNumber"
                                           name="cardNumber"
                                           placeholder="1234 5678 9012 3456"
                                           maxlength="19"
                                           class="form-input w-full px-4 py-3 rounded-xl pr-12">
                                    <div id="cardTypeIcon" class="absolute right-3 top-3"></div>
                                </div>
                            </div>

                            <div class="grid md:grid-cols-2 gap-4">
                                <div>
                                    <label for="expiryDate" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Expiry Date
                                    </label>
                                    <input type="text"
                                           id="expiryDate"
                                           name="expiryDate"
                                           placeholder="MM/YY"
                                           maxlength="5"
                                           class="form-input w-full px-4 py-3 rounded-xl">
                                </div>
                                <div>
                                    <label for="cvv" class="block text-sm font-semibold text-gray-700 mb-2">
                                        CVV
                                    </label>
                                    <input type="text"
                                           id="cvv"
                                           name="cvv"
                                           placeholder="123"
                                           maxlength="4"
                                           class="form-input w-full px-4 py-3 rounded-xl">
                                </div>
                            </div>

                            <div>
                                <label for="cardholderName" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Cardholder Name
                                </label>
                                <input type="text"
                                       id="cardholderName"
                                       name="cardholderName"
                                       placeholder="Enter name as on card"
                                       class="form-input w-full px-4 py-3 rounded-xl">
                            </div>
                        </form>
                    </div>

                    <!-- Other Payment Methods Info -->
                    <div id="bankTransferInfo" class="hidden">
                        <div class="bg-blue-50 p-6 rounded-xl">
                            <h3 class="text-xl font-bold text-blue-800 mb-4">Bank Transfer Details</h3>
                            <div class="space-y-2 text-blue-700">
                                <p><strong>Bank:</strong> Commercial Bank of Ceylon</p>
                                <p><strong>Account Name:</strong> Wild Ceylon Adventures</p>
                                <p><strong>Account Number:</strong> 8001234567890</p>
                                <p><strong>Branch:</strong> Colombo Main Branch</p>
                                <p class="text-sm mt-4">Please use booking ID as reference and contact us after transfer.</p>
                            </div>
                        </div>
                    </div>

                    <div id="cashPaymentInfo" class="hidden">
                        <div class="bg-green-50 p-6 rounded-xl">
                            <h3 class="text-xl font-bold text-green-800 mb-4">Cash Payment</h3>
                            <div class="space-y-2 text-green-700">
                                <p>Cash payment can be made at our office or during the tour.</p>
                                <p><strong>Office Address:</strong> Wild Ceylon Adventures, Colombo 03</p>
                                <p><strong>Office Hours:</strong> 9:00 AM - 6:00 PM (Mon-Sat)</p>
                                <p class="text-sm mt-4">Please bring this booking reference for verification.</p>
                            </div>
                        </div>
                    </div>

                    <!-- Payment Button -->
                    <div class="pt-6">
                        <button type="button"
                                id="paymentBtn"
                                class="btn-primary w-full py-4 px-8 text-white text-xl font-bold rounded-xl disabled:opacity-50 disabled:cursor-not-allowed">
                                <span id="paymentText">
                                    <i class="fas fa-lock mr-2"></i>
                                    Complete Secure Payment
                                </span>
                            <span id="loadingPaymentText" class="loading">
                                    <i class="fas fa-spinner fa-spin mr-2"></i>
                                    Processing Payment...
                                </span>
                        </button>
                    </div>
                </div>

                <!-- Payment Card Preview -->
                <div class="slide-up" style="animation-delay: 0.2s;">
                    <div class="mb-8">
                        <h2 class="text-2xl font-bold text-gray-800 mb-4 text-center">
                            Payment Preview
                        </h2>

                        <!-- Virtual Credit Card -->
                        <div class="relative h-64 perspective-1000" id="cardContainer">
                            <div class="payment-card relative h-full" id="virtualCard">
                                <!-- Card Front -->
                                <div class="card-front">
                                    <div class="flex justify-between items-start mb-8">
                                        <div class="text-2xl font-bold">WILD CEYLON</div>
                                        <div id="cardTypeLogo" class="text-3xl"></div>
                                    </div>
                                    <div class="mb-6">
                                        <div class="text-2xl font-mono tracking-wider" id="displayCardNumber">
                                            •••• •••• •••• ••••
                                        </div>
                                    </div>
                                    <div class="flex justify-between items-end">
                                        <div>
                                            <div class="text-xs text-gray-300">CARDHOLDER NAME</div>
                                            <div class="text-lg font-semibold" id="displayCardholderName">
                                                YOUR NAME
                                            </div>
                                        </div>
                                        <div>
                                            <div class="text-xs text-gray-300">EXPIRES</div>
                                            <div class="text-lg font-semibold" id="displayExpiryDate">
                                                MM/YY
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Card Back -->
                                <div class="card-back">
                                    <div class="bg-black h-12 w-full mb-6 mt-4"></div>
                                    <div class="flex justify-end">
                                        <div class="bg-white text-black px-3 py-2 rounded text-lg font-mono" id="displayCVV">
                                            CVV
                                        </div>
                                    </div>
                                    <div class="mt-8 text-sm text-gray-300">
                                        This card is issued by Wild Ceylon Adventures for demonstration purposes only.
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Security Features -->
                    <div class="bg-white rounded-2xl p-6 shadow-xl">
                        <h3 class="text-xl font-bold text-gray-800 mb-4 text-center">
                            <i class="fas fa-shield-alt text-green-500 mr-2"></i>
                            Secure Payment Features
                        </h3>
                        <div class="space-y-3 text-gray-600">
                            <div class="flex items-center">
                                <i class="fas fa-check-circle text-green-500 mr-3"></i>
                                <span>256-bit SSL Encryption</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-check-circle text-green-500 mr-3"></i>
                                <span>PCI DSS Compliant</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-check-circle text-green-500 mr-3"></i>
                                <span>Fraud Protection</span>
                            </div>
                            <div class="flex items-center">
                                <i class="fas fa-check-circle text-green-500 mr-3"></i>
                                <span>Money Back Guarantee</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include the payment management JavaScript -->
<script src="/js/payment_management/create.js"></script>
</body>
</html>