<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booking Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"
          integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcgl9M+6tnLtTlEm4Wtk2L5L8fGnX0v8w7fDq9K1k5Q8l5Q5e5e5e5e5e5e5e5e5e5e5e5"
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
</head>
<body class="bg-gray-50">
<main class="max-w-7xl mx-auto px-4 py-8">
    <h1 class="text-3xl font-semibold text-gray-800 mb-6">
        <i class="fa-solid fa-calendar-check mr-2 text-indigo-600"></i>Booking Management
    </h1>

    <!-- add right after the H1 -->
    <div class="flex items-center justify-between mb-4">
        <button onclick="history.back()"
                class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-gray-200 hover:bg-gray-300 text-sm text-gray-800">
            <i class="fa-solid fa-arrow-left"></i> Back
        </button>

        <!-- Filter -->
        <div class="flex items-center gap-2">
            <label for="statusFilter" class="text-sm text-gray-600">Filter:</label>
            <select id="statusFilter"
                    class="rounded-md border-gray-300 text-sm focus:ring-indigo-500 focus:border-indigo-500">
                <option value="ALL">All statuses</option>
                <option>PENDING</option>
                <option>FAILED</option>
                <option>COMPLETED</option>
                <option>CANCELLED</option>
            </select>
        </div>
    </div>
    <!-- Table -->
    <div class="bg-white rounded-xl shadow overflow-hidden">
        <div class="overflow-x-auto">
            <table class="min-w-full text-sm text-left text-gray-600">
                <thead class="bg-gray-100 text-gray-700 uppercase tracking-wider">
                <tr>
                    <th class="px-4 py-3">ID</th>
                    <th class="px-4 py-3">Date</th>
                    <th class="px-4 py-3">Customer</th>
                    <th class="px-4 py-3">Email</th>
                    <th class="px-4 py-3">Notes</th>
                    <th class="px-4 py-3">Status</th>

                </tr>
                </thead>
                <tbody id="booking-tbody" class="divide-y divide-gray-200">
                <!-- rows injected by JS -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Toast -->
    <div id="toast"
         class="fixed bottom-5 right-5 hidden items-center px-4 py-3 rounded-lg text-white shadow-lg transition">
        <span id="toast-msg"></span>
    </div>
</main>

<script type="module" src="/js/booking_management/admin_list.js"></script>
</body>
</html>