const form = document.getElementById('login-form');
const emailInp = document.getElementById('email');
const pwInp = document.getElementById('password');
const toggleBtn = document.getElementById('toggle-pw');
const submitBtn = document.getElementById('submit-btn');
const btnText = document.getElementById('btn-text');
const btnIcon = document.getElementById('btn-icon');

const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

toggleBtn.addEventListener('click', () => {
    const type = pwInp.type === 'password' ? 'text' : 'password';
    pwInp.type = type;
    toggleBtn.querySelector('i').classList.toggle('fa-eye');
    toggleBtn.querySelector('i').classList.toggle('fa-eye-slash');
});

function setError(el, show) {
    document.getElementById(el.id + '-err').classList.toggle('hidden', !show);
}

function validate() {
    let ok = true;
    if (!emailRegex.test(emailInp.value.trim())) {
        setError(emailInp, true);
        ok = false;
    } else setError(emailInp, false);

    if (pwInp.value.trim().length < 6) {
        setError(pwInp, true);
        ok = false;
    } else setError(pwInp, false);

    return ok;
}

form.addEventListener('submit', async e => {
    e.preventDefault();
    if (!validate()) return;

    submitBtn.disabled = true;
    btnText.textContent = 'Logging in';
    btnIcon.className = 'fas fa-spinner fa-spin';

    try {
        const res = await fetch('/api/users/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                email: emailInp.value.trim(),
                password: pwInp.value.trim()
            })
        });

        if (res.ok) {
            const result=await res.json()
            localStorage.setItem("userId",result.id)
            location.href = '/';
        } else {
            const msg = await res.text();
            alert(msg || 'Login failed');
        }
    } catch {
        alert('Network error');
    } finally {
        submitBtn.disabled = false;
        btnText.textContent = 'Login';
        btnIcon.className = 'fas fa-sign-in-alt';
    }
});