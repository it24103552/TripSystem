// navbar.js
document.addEventListener('DOMContentLoaded', function() {
    const userId = localStorage.getItem('userId');
    const navLinksContainer = document.getElementById('nav-links');
    const mobileNavLinksContainer = document.getElementById('mobile-nav-links');
    const mobileMenuButton = document.getElementById('mobile-menu-button');
    const mobileMenu = document.getElementById('mobile-menu');

    function createNavLink(text, href) {
        const link = document.createElement('a');
        link.href = href;
        link.className = 'text-white hover:bg-green-600 px-3 py-2 rounded-md text-sm font-medium';
        link.textContent = text;
        return link;
    }

    function updateNavLinks() {
        navLinksContainer.innerHTML = '';
        mobileNavLinksContainer.innerHTML = '';

        if (userId) {
            const links = [
                { text: 'My Bookings', href: '/bookings' },
                { text: 'My Profile', href: '/profile' },
                { text: 'My Payments', href: '/payments' },
                { text: 'Give Feedback', href: '/feedback' },

            ];

            links.forEach(link => {
                const navLink = createNavLink(link.text, link.href);
                if (link.onclick) {
                    navLink.setAttribute('onclick', link.onclick);
                }
                navLinksContainer.appendChild(navLink);

                const mobileLink = createNavLink(link.text, link.href);
                if (link.onclick) {
                    mobileLink.setAttribute('onclick', link.onclick);
                }
                mobileNavLinksContainer.appendChild(mobileLink);
            });
            
            
        } else {
            const loginLink = createNavLink('Login', '/login');
            navLinksContainer.appendChild(loginLink);

            const mobileLoginLink = createNavLink('Login', '/login');
            mobileNavLinksContainer.appendChild(mobileLoginLink);
        }
    }

    function logout() {
        localStorage.removeItem('userId');
        updateNavLinks();
        window.location.href = '/login';
    }

    mobileMenuButton.addEventListener('click', function() {
        mobileMenu.classList.toggle('hidden');
    });

    updateNavLinks();
});