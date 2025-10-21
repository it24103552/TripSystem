<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Feedbacks</title>
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
            <i class="fa-solid fa-comments mr-2 text-indigo-600"></i>User Feedbacks
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
                    <th class="px-4 py-3">Title</th>
                    <th class="px-4 py-3">Sub-Title</th>
                    <th class="px-4 py-3">Stars</th>
                    <th class="px-4 py-3">User</th>
                    <th class="px-4 py-3">Date</th>
                </tr>
                </thead>
                <tbody id="feedback-tbody" class="divide-y divide-gray-200">
                <!-- rows injected -->
                </tbody>
            </table>
        </div>
    </div>
</main>

<script src="/js/feedback_management/admin_feedback.js"></script>
</body>
</html>