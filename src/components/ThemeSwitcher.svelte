<script>
  import { onMount, onDestroy } from "svelte";

  const MEDIA = "(prefers-color-scheme: dark)";
  let mode = "dark"; // "auto" | "light" | "dark"
  let mql;

  const effective = () => (window.matchMedia(MEDIA).matches ? "dark" : "light");

  const apply = (m) => {
    const theme = m === "auto" ? effective() : m;
    document.documentElement.setAttribute("data-theme", theme);
  };

  function setMode(next) {
    mode = next;
    localStorage.setItem("theme-mode", next);
    apply(next);
  }

  function onMediaChange() {
    if (mode === "auto") apply("auto");
  }

  onMount(() => {
    const saved = localStorage.getItem("theme-mode");
    mode = saved || "auto";
    mql = window.matchMedia(MEDIA);
    mql.addEventListener?.("change", onMediaChange);
    apply(mode);
  });

  onDestroy(() => {
    mql?.removeEventListener?.("change", onMediaChange);
  });
</script>

<nav aria-label="Theme switcher">
  <ul class="theme-switcher">
    <li>
      <details class="dropdown">
        <summary class="secondary">Theme</summary>
        <!-- svelte-ignore a11y-invalid-attribute -->
        <ul>
          <li>
            <a
              href="#"
              data-theme-switcher="auto"
              on:click={() => setMode("auto")}>Auto</a
            >
          </li>
          <li>
            <a
              href="#"
              data-theme-switcher="light"
              on:click={() => setMode("light")}>Light</a
            >
          </li>
          <li>
            <a
              href="#"
              data-theme-switcher="dark"
              on:click={() => setMode("dark")}>Dark</a
            >
          </li>
        </ul>
      </details>
    </li>
  </ul>
</nav>

<style>
  .theme-switcher {
    display: flex;
    gap: 0.5rem;
    align-items: center;
  }
</style>
