<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Guide Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body class="bg-gray-50">
<main class="max-w-7xl mx-auto px-4 py-8">
    <!-- Header -->
    <div class="flex items-center justify-between mb-6">
        <h1 class="text-3xl font-semibold text-gray-800">
            <i class="fa-solid fa-person-chalkboard mr-2 text-indigo-600"></i>Guide Management
        </h1>
        <div class="flex items-center gap-3">
            <button onclick="history.back()"
                    class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-gray-200 hover:bg-gray-300 text-sm text-gray-800">
                <i class="fa-solid fa-arrow-left"></i> Back
            </button>
            <button id="openCreateModalBtn"
                    class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white text-sm">
                <i class="fa-solid fa-plus"></i> Add Guide
            </button>
        </div>
    </div>

    <!-- Loading -->
    <div id="loader" class="flex justify-center py-10">
        <i class="fa-solid fa-spinner fa-spin text-3xl text-indigo-600"></i>
    </div>

    <!-- Table -->
    <div id="tableWrapper" class="hidden bg-white rounded-xl shadow overflow-hidden">
        <div class="overflow-x-auto">
            <table class="min-w-full text-sm text-left text-gray-600">
                <thead class="bg-gray-100 text-gray-700 uppercase tracking-wider">
                <tr>
                    <th class="px-4 py-3">ID</th>
                    <th class="px-4 py-3">Name</th>
                    <th class="px-4 py-3">Email</th>
                    <th class="px-4 py-3">Phone</th>
                    <th class="px-4 py-3">Country</th>
                    <th class="px-4 py-3">Vehicle</th>
                    <th class="px-4 py-3">Language</th>
                    <th class="px-4 py-3">Expertise</th>
                    <th class="px-4 py-3 text-center">Actions</th>
                </tr>
                </thead>
                <tbody id="guide-tbody" class="divide-y divide-gray-200">
                <!-- rows injected -->
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ====== Create / Edit Modal ====== -->
<div id="guideModal" class="fixed inset-0 hidden items-center justify-center bg-black bg-opacity-40">
    <div class="bg-white rounded-xl shadow-xl w-full max-w-2xl p-6">
        <h2 id="modalTitle" class="text-xl font-semibold mb-4">Add Guide</h2>
        <form id="guideForm" class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <input type="hidden" id="guideId">
            <input type="hidden" id="userRole" value="GUIDE">

            <!-- First Name -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">First Name</label>
                <input id="firstName" type="text" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Last Name -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Last Name</label>
                <input id="lastName" type="text" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Email -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                <input id="email" type="email" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Phone -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
                <input id="phoneNumber" type="tel" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Country -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Country</label>
                <input id="country" type="text" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Vehicle Type -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Vehicle Type</label>
                <input id="vehicleType" type="text" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Language -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Language</label>
                <input id="language" type="text" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Expertise -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Expertise</label>
                <input id="expertise" type="text" required
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Password (create only) -->
            <div id="passwordWrapper">

                <input id="password" type="hidden" value="password123" minlength="6"
                       class="w-full rounded-md border border-gray-300 bg-white px-3 py-2
                              focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Form Actions -->
            <div class="md:col-span-2 flex justify-end gap-3 pt-2">
                <button type="button" id="cancelBtn"
                        class="px-4 py-2 rounded-lg bg-gray-200 hover:bg-gray-300 text-sm">Cancel</button>
                <button type="submit"
                        class="px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white text-sm">Save</button>
            </div>
        </form>
    </div>
</div>

<!-- Toast -->
<div id="toast"
     class="fixed bottom-5 right-5 hidden items-center px-4 py-3 rounded-lg text-white shadow-lg transition">
    <span id="toast-msg"></span>
</div>

<script type="module" src="/js/user_management/user-management.js"></script>
</body>
</html>
