const form = document.getElementById('register-form');
const fields = ['firstName','lastName','email','phoneNumber','country','password','confirmPassword'];
const inputs = fields.reduce((acc,f)=>(acc[f]=document.getElementById(f),acc),{});
const toggleBtn = document.getElementById('toggle-pw');
const submitBtn = document.getElementById('submit-btn');
const btnText = document.getElementById('btn-text');
const btnIcon = document.getElementById('btn-icon');

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const phoneRegex = /^\d{7,15}$/;

toggleBtn.addEventListener('click', () => {
    const type = inputs.password.type === 'password' ? 'text' : 'password';
    inputs.password.type = type;
    inputs.confirmPassword.type = type;
    toggleBtn.querySelector('i').classList.toggle('fa-eye');
    toggleBtn.querySelector('i').classList.toggle('fa-eye-slash');
});

function setError(name, show) {
    document.getElementById(name + '-err').classList.toggle('hidden', !show);
}

function validate() {
    let ok = true;
    if (!inputs.firstName.value.trim()) { setError('firstName', true); ok = false; } else setError('firstName', false);
    if (!inputs.lastName.value.trim()) { setError('lastName', true); ok = false; } else setError('lastName', false);
    if (!emailRegex.test(inputs.email.value.trim())) { setError('email', true); ok = false; } else setError('email', false);
    if (!phoneRegex.test(inputs.phoneNumber.value.trim())) { setError('phoneNumber', true); ok = false; } else setError('phoneNumber', false);
    if (!inputs.country.value.trim()) { setError('country', true); ok = false; } else setError('country', false);
    if (inputs.password.value.trim().length < 6) { setError('password', true); ok = false; } else setError('password', false);
    if (inputs.password.value !== inputs.confirmPassword.value) { setError('confirmPassword', true); ok = false; } else setError('confirmPassword', false);
    return ok;
}

form.addEventListener('submit', async e => {
    e.preventDefault();
    if (!validate()) return;

    submitBtn.disabled = true;
    btnText.textContent = 'Registering';
    btnIcon.className = 'fas fa-spinner fa-spin';

    try {
        const res = await fetch('/api/users', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                firstName: inputs.firstName.value.trim(),
                lastName: inputs.lastName.value.trim(),
                email: inputs.email.value.trim(),
                phoneNumber: inputs.phoneNumber.value.trim(),
                country: inputs.country.value.trim(),
                password: inputs.password.value.trim(),
                userRole: 'TRAVELER'
            })
        });

        if (res.ok) {
            location.href = 'login';
        } else {
            const msg = await res.text();
            alert(msg || 'Registration failed');
        }
    } catch {
        alert('Network error');
    } finally {
        submitBtn.disabled = false;
        btnText.textContent = 'Register';
        btnIcon.className = 'fas fa-user-plus';
    }
});