<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful - Wild Ceylon</title>
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

        .success-animation {
            animation: successPulse 2s ease-in-out infinite;
        }

        .float-animation {
            animation: float 3s ease-in-out infinite;
        }

        .slide-in {
            animation: slideInUp 1s ease-out;
        }

        .bounce-in {
            animation: bounceIn 1.2s ease-out;
        }

        @keyframes successPulse {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.7);
                transform: scale(1);
            }
            50% {
                box-shadow: 0 0 0 30px rgba(16, 185, 129, 0);
                transform: scale(1.05);
            }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounceIn {
            0% {
                opacity: 0;
                transform: scale(0.3);
            }
            50% {
                opacity: 1;
                transform: scale(1.05);
            }
            70% {
                transform: scale(0.9);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        .btn-home {
            background: linear-gradient(135deg, #10b981, #34d399);
            transition: all 0.3s ease;
        }

        .btn-home:hover {
            background: linear-gradient(135deg, #059669, #10b981);
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
        }

        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: #10b981;
            animation: confetti 3s ease-in-out infinite;
        }

        .confetti:nth-child(1) {
            left: 10%;
            animation-delay: 0s;
            background: #10b981;
        }

        .confetti:nth-child(2) {
            left: 20%;
            animation-delay: 0.5s;
            background: #34d399;
        }

        .confetti:nth-child(3) {
            left: 30%;
            animation-delay: 1s;
            background: #6ee7b7;
        }

        .confetti:nth-child(4) {
            left: 40%;
            animation-delay: 1.5s;
            background: #10b981;
        }

        .confetti:nth-child(5) {
            left: 50%;
            animation-delay: 2s;
            background: #34d399;
        }

        .confetti:nth-child(6) {
            left: 60%;
            animation-delay: 2.5s;
            background: #6ee7b7;
        }

        .confetti:nth-child(7) {
            left: 70%;
            animation-delay: 3s;
            background: #10b981;
        }

        .confetti:nth-child(8) {
            left: 80%;
            animation-delay: 3.5s;
            background: #34d399;
        }

        .confetti:nth-child(9) {
            left: 90%;
            animation-delay: 4s;
            background: #6ee7b7;
        }

        @keyframes confetti {
            0% {
                transform: translateY(-100vh) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100vh) rotate(720deg);
                opacity: 0;
            }
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen">
<!-- Include Navbar -->
<jsp:include page="../common/navbar.jsp"/>

<!-- Confetti Animation -->
<div class="fixed inset-0 pointer-events-none overflow-hidden">
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
    <div class="confetti"></div>
</div>

<div class="gradient-bg min-h-screen flex items-center justify-center py-12">
    <div class="container mx-auto px-6">
        <!-- Success Content -->
        <div class="max-w-4xl mx-auto text-center">
            <!-- Success Icon -->
            <div class="mb-8 bounce-in">
                <div class="w-32 h-32 bg-green-500 rounded-full flex items-center justify-center mx-auto success-animation">
                    <i class="fas fa-check text-white text-6xl"></i>
                </div>
            </div>

            <!-- Success Message -->
            <div class="mb-12 slide-in">
                <h1 class="text-4xl md:text-6xl font-bold text-gray-800 mb-6">
                    Payment <span class="bg-gradient-to-r from-green-500 to-emerald-600 bg-clip-text text-transparent">Successful!</span>
                </h1>
                <p class="text-xl md:text-2xl text-gray-600 mb-8 max-w-3xl mx-auto leading-relaxed">
                    🎉 Congratulations! Your wildlife adventure booking has been confirmed.
                    Get ready for an unforgettable journey through Sri Lanka's pristine wilderness!
                </p>
            </div>

            <!-- Success Details Card -->
            <div class="bg-white rounded-3xl shadow-2xl p-8 md:p-12 mb-12 slide-in mx-auto max-w-2xl" style="animation-delay: 0.3s;">
                <div class="space-y-6">
                    <div class="flex items-center justify-center mb-6">
                        <i class="fas fa-paw text-green-500 text-3xl mr-3"></i>
                        <h2 class="text-2xl md:text-3xl font-bold text-gray-800">Booking Confirmed</h2>
                    </div>

                    <div class="grid md:grid-cols-2 gap-6 text-left">
                        <div class="bg-green-50 p-4 rounded-xl">
                            <div class="flex items-center mb-2">
                                <i class="fas fa-receipt text-green-600 mr-2"></i>
                                <span class="font-semibold text-green-800">Payment Status</span>
                            </div>
                            <p class="text-green-700 font-bold">Completed Successfully</p>
                        </div>

                        <div class="bg-blue-50 p-4 rounded-xl">
                            <div class="flex items-center mb-2">
                                <i class="fas fa-envelope text-blue-600 mr-2"></i>
                                <span class="font-semibold text-blue-800">Confirmation Email</span>
                            </div>
                            <p class="text-blue-700 font-bold">Sent to Your Inbox</p>
                        </div>
                    </div>

                    <div class="bg-gradient-to-r from-green-100 to-emerald-100 p-6 rounded-xl">
                        <h3 class="text-lg font-bold text-green-800 mb-3 flex items-center">
                            <i class="fas fa-info-circle mr-2"></i>
                            What's Next?
                        </h3>
                        <ul class="text-green-700 space-y-2 text-left">
                            <li class="flex items-start">
                                <i class="fas fa-check-circle text-green-600 mr-2 mt-1"></i>
                                <span>Check your email for detailed booking confirmation and itinerary</span>
                            </li>
                            <li class="flex items-start">
                                <i class="fas fa-check-circle text-green-600 mr-2 mt-1"></i>
                                <span>Our team will contact you 24-48 hours before your tour date</span>
                            </li>
                            <li class="flex items-start">
                                <i class="fas fa-check-circle text-green-600 mr-2 mt-1"></i>
                                <span>Prepare for an amazing wildlife adventure experience!</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <!-- Floating Wildlife Icons -->
            <div class="absolute top-20 left-10 float-animation opacity-20">
                <i class="fas fa-leaf text-green-400 text-4xl"></i>
            </div>
            <div class="absolute top-32 right-20 float-animation opacity-20" style="animation-delay: 1s;">
                <i class="fas fa-bird text-yellow-400 text-5xl"></i>
            </div>
            <div class="absolute bottom-32 left-20 float-animation opacity-20" style="animation-delay: 2s;">
                <i class="fas fa-paw text-orange-400 text-4xl"></i>
            </div>
            <div class="absolute bottom-20 right-10 float-animation opacity-20" style="animation-delay: 3s;">
                <i class="fas fa-tree text-green-400 text-6xl"></i>
            </div>

            <!-- Home Button -->
            <div class="bounce-in" style="animation-delay: 0.6s;">
                <a href="/" class="btn-home inline-flex items-center px-8 py-4 text-white text-xl font-bold rounded-full shadow-2xl">
                    <i class="fas fa-home mr-3"></i>
                    Return to Home
                </a>
            </div>

            <!-- Additional Actions -->
            <div class="mt-8 slide-in" style="animation-delay: 0.9s;">
                <p class="text-gray-600 mb-4">Need help or have questions?</p>
                <div class="flex flex-col sm:flex-row gap-4 justify-center">
                    <a href="tel:+94111234567" class="inline-flex items-center px-6 py-3 bg-blue-500 hover:bg-blue-600 text-white font-semibold rounded-xl transition-all duration-300 hover:shadow-lg">
                        <i class="fas fa-phone mr-2"></i>
                        Call Us: +94 11 123 4567
                    </a>
                    <a href="mailto:info@wildceylon.lk" class="inline-flex items-center px-6 py-3 bg-purple-500 hover:bg-purple-600 text-white font-semibold rounded-xl transition-all duration-300 hover:shadow-lg">
                        <i class="fas fa-envelope mr-2"></i>
                        Email: info@wildceylon.lk
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>