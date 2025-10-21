<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wild Ceylon - Wildlife Adventures in Sri Lanka</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
        }

        .hero-bg {
            background: linear-gradient(135deg, rgba(0,0,0,0.6), rgba(0,100,0,0.3)),
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1920 1080"><rect width="1920" height="1080" fill="%23228B22"/><circle cx="300" cy="200" r="100" fill="%23006400" opacity="0.3"/><circle cx="1600" cy="300" r="150" fill="%2332CD32" opacity="0.2"/><polygon points="800,400 900,600 700,600" fill="%23006400" opacity="0.4"/></svg>');
            background-size: cover;
            background-position: center;
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

        .float {
            animation: float 3s ease-in-out infinite;
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

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }

        .card-hover {
            transition: all 0.3s ease;
        }

        .card-hover:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
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

        @keyframes pulseBorder {
            0%, 100% { border-color: #10B981; }
            50% { border-color: #34D399; }
        }
    </style>
</head>
<body class="bg-gray-50">
<!-- Include Navbar -->
<jsp:include page="common/navbar.jsp"/>

<!-- Hero Section -->
<section class="hero-bg min-h-screen flex items-center justify-center relative overflow-hidden">
    <div class="absolute inset-0 bg-black bg-opacity-40"></div>
    <div class="container mx-auto px-6 relative z-10 text-center text-white">
        <div class="fade-in">
            <h1 class="text-5xl md:text-7xl font-bold mb-6 leading-tight">
                Discover <span class="gradient-text">Wild Ceylon</span>
            </h1>
            <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto opacity-90">
                Embark on extraordinary wildlife adventures across Sri Lanka's pristine national parks and reserves
            </p>
            <div class="flex flex-col sm:flex-row gap-4 justify-center bounce-in">
                <button class="bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-8 py-4 rounded-full text-lg font-semibold transform hover:scale-105 transition-all duration-300 shadow-2xl">
                    <i class="fas fa-binoculars mr-2"></i>
                    Explore Wildlife Tours
                </button>
                <button class="bg-transparent border-2 border-white hover:bg-white hover:text-green-600 text-white px-8 py-4 rounded-full text-lg font-semibold transform hover:scale-105 transition-all duration-300">
                    <i class="fas fa-play mr-2"></i>
                    Watch Our Story
                </button>
            </div>
        </div>
    </div>

    <!-- Floating Elements -->
    <div class="absolute top-20 left-10 float">
        <i class="fas fa-leaf text-green-300 text-3xl opacity-20"></i>
    </div>
    <div class="absolute top-40 right-20 float" style="animation-delay: 1s;">
        <i class="fas fa-bird text-yellow-300 text-4xl opacity-20"></i>
    </div>
    <div class="absolute bottom-40 left-20 float" style="animation-delay: 2s;">
        <i class="fas fa-paw text-orange-300 text-3xl opacity-20"></i>
    </div>
</section>

<!-- Popular Destinations -->
<section class="py-20 bg-white">
    <div class="container mx-auto px-6">
        <div class="text-center mb-16 slide-up">
            <h2 class="text-4xl md:text-5xl font-bold text-gray-800 mb-4">
                Popular <span class="gradient-text">Wildlife Destinations</span>
            </h2>
            <p class="text-xl text-gray-600 max-w-2xl mx-auto">
                Explore Sri Lanka's most spectacular national parks and wildlife reserves
            </p>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
            <!-- Yala National Park -->
            <div class="card-hover bg-white rounded-2xl overflow-hidden shadow-xl border pulse-border">
                <div class="h-48 relative overflow-hidden">
                    <img src="https://s1.it.atcdn.net/wp-content/uploads/2018/12/yala.jpg"
                         alt="Yala National Park"
                         class="w-full h-full object-cover transform hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                    <div class="absolute top-4 right-4 bg-red-500 text-white px-3 py-1 rounded-full text-sm font-semibold">
                        Best for Leopards
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-2xl font-bold text-gray-800 mb-2">Yala National Park</h3>
                    <p class="text-gray-600 mb-4">Home to the highest density of leopards in the world. Experience thrilling safari adventures.</p>
                    <div class="flex items-center justify-between">
                        <div class="text-2xl font-bold text-green-600">
                            LKR 15,000
                            <span class="text-sm font-normal text-gray-500">/person</span>
                        </div>
                        <a href="/create-booking?name=Yala National Park&price=15000"
                           class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors inline-block text-center no-underline">
                            Book Now
                        </a>
                    </div>
                </div>
            </div>

            <!-- Udawalawe National Park -->
            <div class="card-hover bg-white rounded-2xl overflow-hidden shadow-xl border pulse-border">
                <div class="h-48 relative overflow-hidden">
                    <img src="https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/82/04/7c/udawalawe-national-park.jpg?w=900&h=-1&s=1"
                         alt="Udawalawe National Park"
                         class="w-full h-full object-cover transform hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                    <div class="absolute top-4 right-4 bg-gray-600 text-white px-3 py-1 rounded-full text-sm font-semibold">
                        Elephant Paradise
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-2xl font-bold text-gray-800 mb-2">Udawalawe National Park</h3>
                    <p class="text-gray-600 mb-4">Famous for its large herds of elephants and diverse bird species in scenic landscapes.</p>
                    <div class="flex items-center justify-between">
                        <div class="text-2xl font-bold text-green-600">
                            LKR 12,500
                            <span class="text-sm font-normal text-gray-500">/person</span>
                        </div>
                        <a href="/create-booking?name=Udawalawe National Park&price=12500"
                           class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors inline-block text-center no-underline">
                            Book Now
                        </a>
                    </div>
                </div>
            </div>

            <!-- Sinharaja Forest -->
            <div class="card-hover bg-white rounded-2xl overflow-hidden shadow-xl border pulse-border">
                <div class="h-48 relative overflow-hidden">
                    <img src="https://lakpura.com/cdn/shop/files/LKI21401591-01-E_feb4678b-ada8-4b84-a35a-c3c6553ef3db.jpg?v=1653379332&width=3200"
                         alt="Sinharaja Forest Reserve"
                         class="w-full h-full object-cover transform hover:scale-110 transition-transform duration-500">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent"></div>
                    <div class="absolute top-4 right-4 bg-emerald-600 text-white px-3 py-1 rounded-full text-sm font-semibold">
                        UNESCO Site
                    </div>
                </div>
                <div class="p-6">
                    <h3 class="text-2xl font-bold text-gray-800 mb-2">Sinharaja Forest Reserve</h3>
                    <p class="text-gray-600 mb-4">Explore the last viable area of primary tropical rainforest in Sri Lanka.</p>
                    <div class="flex items-center justify-between">
                        <div class="text-2xl font-bold text-green-600">
                            LKR 8,500
                            <span class="text-sm font-normal text-gray-500">/person</span>
                        </div>
                        <a href="/create-booking?name=Sinharaja Forest Reserve&price=8500"
                           class="bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-lg transition-colors inline-block text-center no-underline">
                            Book Now
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Features Section -->
<section class="py-20 bg-gray-50">
    <div class="container mx-auto px-6">
        <div class="text-center mb-16 slide-up">
            <h2 class="text-4xl md:text-5xl font-bold text-gray-800 mb-4">
                Why Choose <span class="gradient-text">Wild Ceylon</span>
            </h2>
        </div>

        <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-8">
            <div class="text-center bounce-in">
                <div class="w-20 h-20 bg-gradient-to-br from-blue-500 to-blue-600 rounded-full flex items-center justify-center mx-auto mb-4 float">
                    <i class="fas fa-certificate text-white text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-2">Licensed Guides</h3>
                <p class="text-gray-600">Professional naturalists with deep local knowledge</p>
            </div>

            <div class="text-center bounce-in" style="animation-delay: 0.2s;">
                <div class="w-20 h-20 bg-gradient-to-br from-green-500 to-green-600 rounded-full flex items-center justify-center mx-auto mb-4 float">
                    <i class="fas fa-leaf text-white text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-2">Eco-Friendly</h3>
                <p class="text-gray-600">Sustainable tourism practices that protect wildlife</p>
            </div>

            <div class="text-center bounce-in" style="animation-delay: 0.4s;">
                <div class="w-20 h-20 bg-gradient-to-br from-purple-500 to-purple-600 rounded-full flex items-center justify-center mx-auto mb-4 float">
                    <i class="fas fa-camera text-white text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-2">Photography Tours</h3>
                <p class="text-gray-600">Capture stunning wildlife moments with expert tips</p>
            </div>

            <div class="text-center bounce-in" style="animation-delay: 0.6s;">
                <div class="w-20 h-20 bg-gradient-to-br from-orange-500 to-orange-600 rounded-full flex items-center justify-center mx-auto mb-4 float">
                    <i class="fas fa-shield-alt text-white text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold text-gray-800 mb-2">Safe Adventures</h3>
                <p class="text-gray-600">Fully insured tours with safety as top priority</p>
            </div>
        </div>
    </div>
</section>

<!-- Call to Action -->
<section class="py-20 bg-gradient-to-r from-green-600 to-emerald-700">
    <div class="container mx-auto px-6 text-center">
        <div class="fade-in">
            <h2 class="text-4xl md:text-5xl font-bold text-white mb-6">
                Ready for Your Wildlife Adventure?
            </h2>
            <p class="text-xl text-green-100 mb-8 max-w-2xl mx-auto">
                Join thousands of nature lovers who have experienced the magic of Sri Lankan wildlife with us
            </p>
            <div class="flex flex-col sm:flex-row gap-4 justify-center">
                <button class="bg-white text-green-600 px-8 py-4 rounded-full text-lg font-semibold transform hover:scale-105 transition-all duration-300 shadow-2xl hover:shadow-white/20">
                    <i class="fas fa-calendar-alt mr-2"></i>
                    Book Your Trip Now
                </button>
                <button class="border-2 border-white text-white px-8 py-4 rounded-full text-lg font-semibold transform hover:scale-105 transition-all duration-300 hover:bg-white hover:text-green-600">
                    <i class="fas fa-phone mr-2"></i>
                    Call +94 11 123 4567
                </button>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-gray-800 text-white py-12">
    <div class="container mx-auto px-6">
        <div class="grid md:grid-cols-4 gap-8">
            <div>
                <h3 class="text-2xl font-bold gradient-text mb-4">Wild Ceylon</h3>
                <p class="text-gray-300 mb-4">Your gateway to Sri Lanka's incredible wildlife experiences.</p>
                <div class="flex space-x-4">
                    <a href="#" class="text-gray-400 hover:text-green-400 transition-colors">
                        <i class="fab fa-facebook-f text-xl"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-green-400 transition-colors">
                        <i class="fab fa-instagram text-xl"></i>
                    </a>
                    <a href="#" class="text-gray-400 hover:text-green-400 transition-colors">
                        <i class="fab fa-twitter text-xl"></i>
                    </a>
                </div>
            </div>
            <div>
                <h4 class="text-lg font-semibold mb-4">Quick Links</h4>
                <ul class="space-y-2 text-gray-300">
                    <li><a href="#" class="hover:text-green-400 transition-colors">National Parks</a></li>
                    <li><a href="#" class="hover:text-green-400 transition-colors">Wildlife Tours</a></li>
                    <li><a href="#" class="hover:text-green-400 transition-colors">Photography Tours</a></li>
                    <li><a href="#" class="hover:text-green-400 transition-colors">About Us</a></li>
                </ul>
            </div>
            <div>
                <h4 class="text-lg font-semibold mb-4">Destinations</h4>
                <ul class="space-y-2 text-gray-300">
                    <li><a href="#" class="hover:text-green-400 transition-colors">Yala National Park</a></li>
                    <li><a href="#" class="hover:text-green-400 transition-colors">Udawalawe</a></li>
                    <li><a href="#" class="hover:text-green-400 transition-colors">Sinharaja Forest</a></li>
                    <li><a href="#" class="hover:text-green-400 transition-colors">Minneriya</a></li>
                </ul>
            </div>
            <div>
                <h4 class="text-lg font-semibold mb-4">Contact Info</h4>
                <div class="space-y-2 text-gray-300">
                    <p><i class="fas fa-map-marker-alt mr-2 text-green-400"></i>Colombo, Sri Lanka</p>
                    <p><i class="fas fa-phone mr-2 text-green-400"></i>+94 11 123 4567</p>
                    <p><i class="fas fa-envelope mr-2 text-green-400"></i>info@wildceylon.lk</p>
                </div>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-8 text-center text-gray-400">
            <p>&copy; 2024 Wild Ceylon. All rights reserved. | Discover Sri Lanka's Wildlife Heritage</p>
        </div>
    </div>
</footer>

<script>
    // Add smooth scrolling animations on scroll
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    // Observe all elements with animation classes
    document.querySelectorAll('.slide-up, .bounce-in').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'all 0.6s ease';
        observer.observe(el);
    });

    // Add interactive hover effects
    document.querySelectorAll('.card-hover').forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'translateY(-10px) scale(1.02)';
        });

        card.addEventListener('mouseleave', () => {
            card.style.transform = 'translateY(0) scale(1)';
        });
    });
</script>
</body>
</html>