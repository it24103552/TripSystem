<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Payments - Wild Ceylon</title>
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
    </style>
</head>
<body class="bg-gray-50">
<jsp:include page="../common/navbar.jsp"/>

<section class="bg-gradient-to-r from-green-600 to-emerald-700 py-16">
    <div class="container mx-auto px-6">
        <div class="text-center text-white fade-in">
            <h1 class="text-4xl md:text-5xl font-bold mb-4">
                My <span class="gradient-text">Payments</span>
            </h1>
            <p class="text-xl text-green-100 max-w-2xl mx-auto">
                Track your payment history for wildlife adventures
            </p>
        </div>
    </div>
</section>

<div class="container mx-auto px-6 py-12">
    <div class="bg-white rounded-2xl shadow-xl p-8 bounce-in">
        <div class="flex items-center mb-6">
            <div class="w-12 h-12 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mr-4">
                <i class="fas fa-credit-card text-white text-xl"></i>
            </div>
            <h2 class="text-2xl font-bold text-gray-800">Payment History</h2>
        </div>

        <div id="paymentsList" class="space-y-6">
            <!-- Payments will be loaded here -->
        </div>
    </div>
</div>

<script src="/js/payment_management/traveler_list.js"></script>
</body>
</html>