// Set default theme to 'dark'
const saved = localStorage.getItem("theme-mode");
document.documentElement.dataset.theme = saved || "dark";

// Global CSS
import "@picocss/pico/css/pico.min.css"; // Pico (class-based)
import "./styles/global.css"; // Global CSS
import "./styles/form.css";
import "./styles/tokens.css"; // Optional theming tokens

import App from "./App.svelte";

new App({ target: document.getElementById("app") });
