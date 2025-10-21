<jsp:include page="common/navbar.jsp"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" integrity="sha512-2SwdPD6INVrV/lHTZbO2nodKhrnDdJK9/kg2XD1r9uGqPo1cUbujc+IYdlYdEErWNu69gVcYgdxlmVmzTWnetw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<div id="login-root" class="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100 flex items-center justify-center p-4">
    <div class="w-full max-w-md">
        <form id="login-form" class="bg-white rounded-2xl shadow-xl p-8 space-y-6">
            <div class="text-center">
                <i class="fas fa-sign-in-alt text-indigo-600 text-4xl mb-2"></i>
                <h1 class="text-2xl font-bold text-gray-800">Sign In</h1>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <div class="relative">
                    <i class="fas fa-envelope absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input id="email" type="email" placeholder="you@example.com" class="w-full pl-10 pr-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"/>
                </div>
                <span id="email-err" class="text-red-500 text-xs hidden">Invalid email</span>
            </div>

            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                <div class="relative">
                    <i class="fas fa-lock absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"></i>
                    <input id="password" type="password" placeholder="••••••••" class="w-full pl-10 pr-10 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"/>
                    <button type="button" id="toggle-pw" class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600">
                        <i class="fas fa-eye"></i>
                    </button>
                </div>
                <span id="password-err" class="text-red-500 text-xs hidden">Min 6 characters</span>
            </div>

            <button id="submit-btn" type="submit" class="w-full bg-indigo-600 text-white py-2 rounded-lg hover:bg-indigo-700 transition flex items-center justify-center space-x-2">
                <span id="btn-text">Login</span>
                <i id="btn-icon" class="fas fa-sign-in-alt"></i>
            </button>

            <div class="text-center text-sm">
                <span class="text-gray-600">New here?</span>
                <a href="register" class="text-indigo-600 hover:underline ml-1">Create an account</a>
            </div>
        </form>
    </div>
</div>
<script src="/js/login.js"></script>