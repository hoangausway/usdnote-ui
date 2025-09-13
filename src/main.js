// Global CSS
import "@picocss/pico/css/pico.min.css";   // Pico (class-based)
import "./styles/tokens.css";              // Optional theming tokens

import App from "./App.svelte";

new App({ target: document.getElementById("app") });
