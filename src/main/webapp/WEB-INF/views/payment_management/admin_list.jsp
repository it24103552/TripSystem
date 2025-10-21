<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Management</title>
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
            <i class="fa-solid fa-credit-card mr-2 text-indigo-600"></i>Payments
        </h1>
        <button onclick="history.back()"
                class="inline-flex items-center gap-2 px-3 py-2 rounded-lg bg-gray-200 hover:bg-gray-300 text-sm text-gray-800">
            <i class="fa-solid fa-arrow-left"></i> Back
        </button>
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
                    <th class="px-4 py-3">Amount</th>
                    <th class="px-4 py-3">Method</th>
                    <th class="px-4 py-3">Status</th>
                    <th class="px-4 py-3">Paid By</th>
                    <th class="px-4 py-3">Booking</th>
                    <th class="px-4 py-3 text-center">Actions</th>
                </tr>
                </thead>
                <tbody id="payment-tbody" class="divide-y divide-gray-200">
                <!-- rows injected -->
                </tbody>
            </table>
        </div>
    </div>
</main>

<!-- ====== Edit Modal ====== -->
<div id="editModal" class="fixed inset-0 hidden items-center justify-center bg-black bg-opacity-40">
    <div class="bg-white rounded-xl shadow-xl w-full max-w-lg p-6">
        <h2 class="text-xl font-semibold mb-4">Edit Payment</h2>
        <form id="editForm" class="space-y-4">
            <input type="hidden" id="paymentId">

            <!-- Amount -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Amount</label>
                <input id="amount" type="number" step="0.01" required
                       class="w-full rounded-md border-gray-300 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Method -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Method</label>
                <select id="method" required
                        class="w-full rounded-md border-gray-300 focus:ring-indigo-500 focus:border-indigo-500">
                    <option>CASH</option>
                    <option>CARD</option>
                    <option>BANK_TRANSFER</option>
                    <option>EWALLET</option>
                </select>
            </div>

            <!-- Status -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                <select id="status" required
                        class="w-full rounded-md border-gray-300 focus:ring-indigo-500 focus:border-indigo-500">
                    <option>PENDING</option>
                    <option>COMPLETED</option>
                    <option>FAILED</option>
                    <option>REFUNDED</option>
                </select>
            </div>

            <!-- Paid By -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Paid By (User ID)</label>
                <input id="paidBy" type="number" required
                       class="w-full rounded-md border-gray-300 focus:ring-indigo-500 focus:border-indigo-500">
            </div>

            <!-- Paid To Booking -->
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Paid To Booking ID</label>
                <input id="paidTo" type="number" required
                       class="w-full rounded-md border-gray-300 focus:ring-indigo-500 focus:border-indigo-500">
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

<script type="module" src="/js/payment_management/admin_list.js"></script>
</body>
</html>