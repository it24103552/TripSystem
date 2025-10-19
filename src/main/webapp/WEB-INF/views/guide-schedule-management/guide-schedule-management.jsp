<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Guide Schedule Management</title>
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
            <i class="fa-solid fa-calendar-day mr-2 text-indigo-600"></i>Guide Schedules
        </h1>
        <div class="flex items-center gap-3">
            <button onclick="history.back()"
                    class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-gray-200 hover:bg-gray-300 text-sm text-gray-800">
                <i class="fa-solid fa-arrow-left"></i> Back
            </button>
            <button id="openCreateModalBtn"
                    class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white text-sm">
                <i class="fa-solid fa-plus"></i> New Schedule
            </button>
        </div>
    </div>

    <!-- Table -->
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <div class="overflow-x-auto">
            <table class="min-w-full text-sm text-left text-gray-600">
                <thead class="bg-gray-100 text-gray-700 uppercase tracking-wider">
                <tr>
                    <th class="px-4 py-3">ID</th>
                    <th class="px-4 py-3">Guide</th>
                    <th class="px-4 py-3">Booking ID</th>
                    <th class="px-4 py-3">Booking Date</th>
                    <th class="px-4 py-3 text-center">Actions</th>
                </tr>
                </thead>
                <tbody id="schedule-tbody" class="divide-y divide-gray-200">
                <!-- rows injected -->
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ====== Modal ====== -->
<div id="scheduleModal" class="fixed inset-0 hidden items-center justify-center bg-black bg-opacity-40">
    <div class="bg-white rounded-xl shadow-xl w-full max-w-md p-6">
        <h2 id="modalTitle" class="text-xl font-semibold mb-4">Create Schedule</h2>

        <form id="scheduleForm" class="space-y-4">
            <input type="hidden" id="scheduleId">

            <!-- Guide dropdown -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Guide</label>
                <select id="guideSelect" required
                        class="w-full rounded-md border-gray-300 focus:ring-indigo-500 focus:border-indigo-500"></select>
            </div>

            <!-- Booking dropdown -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Booking</label>
                <select id="bookingSelect" required
                        class="w-full rounded-md border-gray-300 focus:ring-indigo-500 focus:border-indigo-500"></select>
            </div>

            <div class="flex justify-end gap-3 pt-2">
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

<script type="module" src="/js/guide-schedule-management/guide-schedule-management.js"></script>
</body>
</html>