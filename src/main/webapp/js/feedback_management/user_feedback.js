document.addEventListener('DOMContentLoaded', function() {
    const API_BASE = '/api/feedbacks';
    let currentUserId = null;
    let editingId = null;
    let deleteId = null;

    // Initialize
    init();

    function init() {
        currentUserId = localStorage.getItem('userId');
        if (!currentUserId) {
            alert('Please login first');
            return;
        }

        loadUserFeedbacks();
        setupEventListeners();
    }

    function setupEventListeners() {
        document.getElementById('feedbackForm').addEventListener('submit', handleSubmit);
        document.getElementById('cancelBtn').addEventListener('click', resetForm);
        document.getElementById('confirmDelete').addEventListener('click', confirmDelete);
        document.getElementById('cancelDelete').addEventListener('click', closeDeleteModal);

        // Close modal on outside click
        document.getElementById('deleteModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeDeleteModal();
            }
        });
    }

    async function handleSubmit(e) {
        e.preventDefault();

        if (!validateForm()) {
            return;
        }

        const formData = {
            title: document.getElementById('title').value.trim(),
            subTitle: document.getElementById('subTitle').value.trim(),
            numOfStars: parseInt(document.getElementById('numOfStars').value),
            userId: parseInt(currentUserId),
            deleteStatus: false
        };

        try {
            let response;
            if (editingId) {
                response = await fetch(`${API_BASE}/${editingId}`, {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                });
            } else {
                response = await fetch(API_BASE, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(formData)
                });
            }

            if (response.ok) {
                resetForm();
                loadUserFeedbacks();
                alert(editingId ? 'Feedback updated successfully' : 'Feedback created successfully');
            } else {
                const errorData = await response.text();
                alert('Error: ' + errorData);
            }
        } catch (error) {
            alert('Network error: ' + error.message);
        }
    }

    function validateForm() {
        let isValid = true;

        // Title validation
        const title = document.getElementById('title').value.trim();
        const titleError = document.getElementById('titleError');
        const titleRegex = /^.{3,}$/;

        if (!title || !titleRegex.test(title)) {
            titleError.classList.remove('hidden');
            isValid = false;
        } else {
            titleError.classList.add('hidden');
        }

        // Subtitle validation
        const subTitle = document.getElementById('subTitle').value.trim();
        const subTitleError = document.getElementById('subTitleError');
        const subTitleRegex = /^[A-Za-z\s]{10,}$/;


        if (!subTitle || !subTitleRegex.test(subTitle)) {
            subTitleError.classList.remove('hidden');
            isValid = false;
        } else {
            subTitleError.classList.add('hidden');
        }

        // Stars validation
        const numOfStars = document.getElementById('numOfStars').value;
        const starsError = document.getElementById('starsError');
        const starsRegex = /^[1-5]$/;

        if (!numOfStars || !starsRegex.test(numOfStars)) {
            starsError.classList.remove('hidden');
            isValid = false;
        } else {
            starsError.classList.add('hidden');
        }

        return isValid;
    }

    async function loadUserFeedbacks() {
        try {
            const response = await fetch(`${API_BASE}/user/${currentUserId}`);
            if (response.ok) {
                const feedbacks = await response.json();
                renderFeedbacks(feedbacks);
            } else {
                console.error('Failed to load feedbacks');
            }
        } catch (error) {
            console.error('Error loading feedbacks:', error);
        }
    }

    function renderFeedbacks(feedbacks) {
        const container = document.getElementById('feedbackList');

        if (feedbacks.length === 0) {
            container.innerHTML = `
                <div class="text-center py-12">
                    <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-comment-slash text-gray-400 text-3xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-600 mb-2">No Feedbacks Yet</h3>
                    <p class="text-gray-500">Create your first feedback to share your wildlife experience</p>
                </div>
            `;
            return;
        }

        container.innerHTML = feedbacks.map(feedback => `
            <div class="border-2 border-gray-100 rounded-2xl p-6 card-hover pulse-border transition-all duration-300">
                <div class="flex justify-between items-start mb-4">
                    <div class="flex-1">
                        <h3 class="text-xl font-bold text-gray-800 mb-2">${escapeHtml(feedback.title)}</h3>
                        <div class="flex items-center mb-3">
                            <span class="star-rating text-lg mr-2">${'★'.repeat(feedback.numOfStars)}</span>
                            <span class="star-empty text-lg">${'★'.repeat(5 - feedback.numOfStars)}</span>
                            <span class="ml-2 text-sm text-gray-600 font-medium">${feedback.numOfStars}/5 Stars</span>
                        </div>
                    </div>
                    <div class="flex space-x-3">
                        <button onclick="editFeedback(${feedback.id})" 
                                class="bg-blue-100 hover:bg-blue-200 text-blue-700 px-4 py-2 rounded-lg transition-colors duration-200 font-medium">
                            <i class="fas fa-edit mr-1"></i>Edit
                        </button>
                        <button onclick="deleteFeedback(${feedback.id})" 
                                class="bg-red-100 hover:bg-red-200 text-red-700 px-4 py-2 rounded-lg transition-colors duration-200 font-medium">
                            <i class="fas fa-trash mr-1"></i>Delete
                        </button>
                    </div>
                </div>
                <p class="text-gray-700 leading-relaxed mb-4">${escapeHtml(feedback.subTitle)}</p>
                <div class="flex items-center justify-between pt-4 border-t border-gray-100">
                    <div class="text-sm text-gray-500 flex items-center">
                        <i class="fas fa-calendar-alt mr-1 text-green-500"></i>
                        <span>Created: ${new Date(feedback.createdAt).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric'
        })}</span>
                    </div>
                    ${feedback.deleteStatus ?
            '<span class="bg-red-100 text-red-700 px-3 py-1 rounded-full text-sm font-medium">Inactive</span>' :
            '<span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm font-medium">Active</span>'
        }
                </div>
            </div>
        `).join('');
    }

    async function editFeedback(id) {
        try {
            const response = await fetch(`${API_BASE}/${id}`);
            if (response.ok) {
                const feedback = await response.json();
                populateForm(feedback);
            }
        } catch (error) {
            alert('Error loading feedback: ' + error.message);
        }
    }

    function populateForm(feedback) {
        editingId = feedback.id;
        document.getElementById('feedbackId').value = feedback.id;
        document.getElementById('title').value = feedback.title;
        document.getElementById('subTitle').value = feedback.subTitle;
        document.getElementById('numOfStars').value = feedback.numOfStars;

        document.getElementById('formTitle').textContent = 'Update Feedback';
        document.getElementById('submitBtn').textContent = 'Update Feedback';

        // Scroll to form
        document.getElementById('feedbackForm').scrollIntoView({ behavior: 'smooth' });
    }

    function deleteFeedback(id) {
        deleteId = id;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    async function confirmDelete() {
        if (!deleteId) return;

        try {
            const response = await fetch(`${API_BASE}/${deleteId}`, {
                method: 'DELETE'
            });

            if (response.ok) {
                loadUserFeedbacks();
                closeDeleteModal();
                alert('Feedback deleted successfully');
            } else {
                const errorData = await response.text();
                alert('Error deleting feedback: ' + errorData);
            }
        } catch (error) {
            alert('Network error: ' + error.message);
        }
    }

    function closeDeleteModal() {
        document.getElementById('deleteModal').classList.add('hidden');
        deleteId = null;
    }

    function resetForm() {
        document.getElementById('feedbackForm').reset();
        document.getElementById('feedbackId').value = '';
        editingId = null;

        // Hide all error messages
        document.querySelectorAll('.text-red-500').forEach(error => {
            error.classList.add('hidden');
        });

        document.getElementById('formTitle').textContent = 'Create New Feedback';
        document.getElementById('submitBtn').textContent = 'Create Feedback';
    }

    function escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    // Make functions globally available
    window.editFeedback = editFeedback;
    window.deleteFeedback = deleteFeedback;
});