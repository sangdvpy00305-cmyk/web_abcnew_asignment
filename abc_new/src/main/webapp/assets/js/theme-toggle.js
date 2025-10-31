/**
 * Theme Toggle JavaScript
 * Handles dark/light mode switching and persistence
 */

class ThemeManager {
    constructor() {
        this.STORAGE_KEY = 'abc-news-theme';
        this.THEME_DARK = 'dark';
        this.THEME_LIGHT = 'light';
        
        this.init();
    }

    init() {
        // Load saved theme or default to light
        const savedTheme = this.getSavedTheme();
        this.setTheme(savedTheme);
        
        // Add event listeners
        this.bindEvents();
    }

    getSavedTheme() {
        const saved = localStorage.getItem(this.STORAGE_KEY);
        
        // If no saved preference, check system preference
        if (!saved) {
            if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
                return this.THEME_DARK;
            }
            return this.THEME_LIGHT;
        }
        
        return saved;
    }

    setTheme(theme) {
        const html = document.documentElement;
        
        if (theme === this.THEME_DARK) {
            html.setAttribute('data-theme', 'dark');
        } else {
            html.removeAttribute('data-theme');
        }
        
        // Update toggle button icon
        this.updateToggleButton(theme);
        
        // Save preference
        localStorage.setItem(this.STORAGE_KEY, theme);
    }

    toggleTheme() {
        const currentTheme = this.getCurrentTheme();
        const newTheme = currentTheme === this.THEME_DARK ? this.THEME_LIGHT : this.THEME_DARK;
        this.setTheme(newTheme);
    }

    getCurrentTheme() {
        return document.documentElement.hasAttribute('data-theme') ? this.THEME_DARK : this.THEME_LIGHT;
    }

    updateToggleButton(theme) {
        const toggleBtn = document.getElementById('theme-toggle');
        if (toggleBtn) {
            if (theme === this.THEME_DARK) {
                toggleBtn.innerHTML = '☀️';
                toggleBtn.title = 'Chuyển sang chế độ sáng';
                toggleBtn.setAttribute('aria-label', 'Chuyển sang chế độ sáng');
            } else {
                toggleBtn.innerHTML = '🌙';
                toggleBtn.title = 'Chuyển sang chế độ tối';
                toggleBtn.setAttribute('aria-label', 'Chuyển sang chế độ tối');
            }
        }
    }

    bindEvents() {
        // Theme toggle button click
        document.addEventListener('click', (e) => {
            if (e.target.id === 'theme-toggle') {
                e.preventDefault();
                this.toggleTheme();
            }
        });

        // Listen for system theme changes
        if (window.matchMedia) {
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
                // Only auto-switch if user hasn't manually set a preference
                const savedTheme = localStorage.getItem(this.STORAGE_KEY);
                if (!savedTheme) {
                    this.setTheme(e.matches ? this.THEME_DARK : this.THEME_LIGHT);
                }
            });
        }

        // Handle page navigation (for SPAs or dynamic content)
        document.addEventListener('DOMContentLoaded', () => {
            this.updateToggleButton(this.getCurrentTheme());
        });
    }

    // Public method to get current theme (for other scripts)
    getTheme() {
        return this.getCurrentTheme();
    }

    // Public method to check if dark mode is active
    isDarkMode() {
        return this.getCurrentTheme() === this.THEME_DARK;
    }
}

// Initialize theme manager when DOM is ready
document.addEventListener('DOMContentLoaded', function() {
    window.themeManager = new ThemeManager();
});

// Also initialize immediately if DOM is already loaded
if (document.readyState === 'loading') {
    // DOM is still loading
    document.addEventListener('DOMContentLoaded', function() {
        if (!window.themeManager) {
            window.themeManager = new ThemeManager();
        }
    });
} else {
    // DOM is already loaded
    if (!window.themeManager) {
        window.themeManager = new ThemeManager();
    }
}