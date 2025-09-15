<script>
  import { tick } from "svelte";
  import Icon from "./Icon.svelte";

  // ===== Props =====
  export let id = "app-drawer"; // match Header MenuButton aria-controls
  export let open = false; // bind:open from parent
  export let title = "Menu"; // for aria-labelledby
  export let logoText = "USDNote";
  export let logoSrc = ""; // optional brand image src
  export let width = 340; // px

  // item: { label, href, icon?, badge?, active? } or { separator: true }
  export let items = [];
  export let sections = null; // [{ heading?, items:[...] }]
  export let footerItems = [];
  export let activeHref = ""; // highlight current route
  export let user = null; // { name, email }

  let panel;
  let prevFocus;

  function close() {
    open = false;
  }

  async function focusFirst() {
    await tick();
    const first = panel?.querySelector(
      "a,button,[tabindex]:not([tabindex='-1'])"
    );
    if (first) first.focus();
    else panel?.focus?.(); // fallback: focus dialog itself
  }

  // Lock scroll + move/restore focus when `open` changes
  $: {
    const html = document.documentElement;
    if (open) {
      prevFocus = document.activeElement;
      html.classList.add("no-scroll");
      focusFirst();
    } else {
      html.classList.remove("no-scroll");
      prevFocus && prevFocus.focus?.();
    }
  }

  // ESC to close
  function onKeydown(e) {
    if (open && e.key === "Escape") close();
  }
</script>

<svelte:window on:keydown={onKeydown} />

{#if open}
  <!-- Scrim (button for a11y) -->
  <button
    class="scrim"
    type="button"
    aria-label="Close menu"
    on:click={close}
  />

  <!-- Focus sentinel (start) -->
  <!-- <div
    tabindex="0"
    on:focus={() => {
      const t = panel?.querySelector(".icon.close, .p-nav a, .p-foot a");
      (t || panel)?.focus?.();
    }}
  /> -->

  <aside
    bind:this={panel}
    {id}
    role="dialog"
    aria-modal="true"
    aria-labelledby="panel-title"
    class="panel"
    tabindex="-1"
    style={`--w:${width}px`}
  >
    <!-- Header: brand + close -->
    <header class="p-head">
      <div class="brand">
        {#if logoSrc}<img src={logoSrc} alt={`${logoText} logo`} />{/if}
        <span id="panel-title" class="t">{title || logoText}</span>
      </div>
      <!-- <button
        class="icon close"
        type="button"
        aria-label="Close menu"
        on:click={close}>×</button
      > -->
    </header>

    <!-- Primary navigation -->
    <nav class="p-nav" aria-label="Primary" on:click={close}>
      {#if sections}
        {#each sections as sec}
          {#if sec.heading}<div class="sec">{sec.heading}</div>{/if}
          {#each sec.items as it}
            {#if it.separator}
              <hr />
            {:else}
              <a
                class="nav-item"
                class:active={it.active ||
                  (activeHref && it.href === activeHref)}
                href={it.href}
              >
                <span class="ic" aria-hidden="true"
                  >{#if it.icon}<Icon name={it.icon} />{/if}</span
                >
                <span class="lbl">{it.label}</span>
                {#if it.badge}<span class="badge">{it.badge}</span>{/if}
              </a>
            {/if}
          {/each}
        {/each}
      {:else}
        {#each items as it}
          {#if it.separator}
            <hr />
          {:else}
            <a
              class="nav-item"
              class:active={it.active || (activeHref && it.href === activeHref)}
              href={it.href}
            >
              <span class="ic" aria-hidden="true"
                >{#if it.icon}<Icon name={it.icon} />{/if}</span
              >
              <span class="lbl">{it.label}</span>
              {#if it.badge}<span class="badge">{it.badge}</span>{/if}
            </a>
          {/if}
        {/each}
      {/if}
    </nav>

    <!-- User card (optional) -->
    {#if user}
      <section class="u-card">
        <div class="u-text">
          <strong>{user.name || "User"}</strong>
          <small class="muted">{user.email}</small>
        </div>
      </section>
    {/if}

    <!-- Footer links -->
    {#if footerItems && footerItems.length}
      <footer class="p-foot" aria-label="Secondary" on:click={close}>
        {#each footerItems as it}
          {#if it.separator}
            <hr />
          {:else}
            <a class="nav-item" href={it.href}>
              <span class="ic" aria-hidden="true"
                >{#if it.icon}<Icon name={it.icon} />{/if}</span
              >
              <span class="lbl">{it.label}</span>
            </a>
          {/if}
        {/each}
      </footer>
    {/if}
  </aside>

  <!-- Focus sentinel (end) -->
  <div
    tabindex="0"
    on:focus={() => (panel || document.activeElement)?.focus?.()}
  />
{/if}

<style>
  /* ---------- Overlay ---------- */
  .scrim {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.45);
    backdrop-filter: blur(2px);
    z-index: 9998;
    border: 0;
    padding: 0;
  }

  /* ---------- Panel (single source of truth) ---------- */
  .panel {
    position: fixed;
    inset-block: 0;
    inset-inline-start: 0;
    inline-size: min(var(--w), 86vw);
    display: grid;
    grid-template-rows: auto auto 1fr auto;
    gap: 0.75rem;
    padding: 0.9rem;
    z-index: 9999;

    /* Theme hooks — derive from Pico tokens */
    --sp-accent: var(--pico-primary);
    --sp-bg: var(--pico-primary-background);
    --sp-fg: var(--pico-primary-inverse); /* <- panel text color */
    --sp-sep: color-mix(in srgb, var(--sp-fg), transparent 65%);

    background: var(--sp-bg);
    color: var(--sp-fg);

    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.45);
    border-right: 1px solid color-mix(in srgb, var(--sp-fg), transparent 80%);

    animation: slideIn 0.18s ease-out;
  }

  /* Ensure black text in DARK theme per your requirement */
  :global(html[data-theme="dark"]) .panel {
    --sp-fg: #000; /* force black text on amber in dark mode */
  }

  @keyframes slideIn {
    from {
      transform: translateX(-10%);
      opacity: 0.9;
    }
    to {
      transform: none;
      opacity: 1;
    }
  }
  @media (prefers-reduced-motion: reduce) {
    .panel {
      animation: none;
    }
  }

  /* ---------- Typography + link reset (inherit panel color) ---------- */
  .panel
    :is(h1, h2, h3, h4, h5, h6, p, small, strong, em, span, li, div, button) {
    color: inherit;
  }
  .panel a,
  .panel a:link,
  .panel a:visited {
    color: inherit;
    text-decoration-color: color-mix(in srgb, currentColor, transparent 60%);
  }
  .panel a:hover {
    background: color-mix(in srgb, currentColor, transparent 93%);
  }
  .panel a:focus-visible {
    outline: 2px solid color-mix(in srgb, var(--sp-accent), currentColor 10%);
    outline-offset: 2px;
  }

  /* ---------- Header ---------- */
  .p-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .brand {
    display: flex;
    align-items: center;
    gap: 0.6rem;
  }
  .brand img {
    height: 22px;
    width: auto;
    display: block;
    filter: drop-shadow(0 1px 0 rgba(0, 0, 0, 0.2));
  }
  .brand .t {
    font-weight: 600;
    letter-spacing: 0.2px;
  }

  /* ---------- User card ---------- */
  .u-card {
    display: grid;
    grid-template-columns: auto 1fr;
    gap: 0.75rem;
    align-items: center;
    padding: 0.6rem 0.5rem;
    background: color-mix(in srgb, var(--sp-accent), transparent 90%);
    border: 1px solid color-mix(in srgb, var(--sp-accent), transparent 75%);
    border-radius: 0.8rem;
  }
  .u-text strong {
    display: block;
  }
  .muted {
    color: color-mix(in srgb, var(--sp-fg), transparent 25%);
  }

  /* ---------- Section heading ---------- */
  .sec {
    margin: 0.75rem 0.25rem 0.25rem;
    color: color-mix(in srgb, var(--sp-fg), transparent 30%);
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.08em;
  }

  /* ---------- Nav list ---------- */
  .p-nav {
    overflow: auto;
    padding-inline: 0.1rem;
  }
  .nav-item {
    display: grid;
    grid-template-columns: 24px 1fr auto;
    align-items: center;
    gap: 0.7rem;
    padding: 0.6rem 0.5rem;
    border-bottom: 1px solid color-mix(in srgb, var(--sp-fg), transparent 75%);
    text-decoration: none;
    position: relative;
  }
  .nav-item:hover {
    background: color-mix(in srgb, currentColor, transparent 93%);
  }
  .nav-item:focus-visible {
    outline: 2px solid color-mix(in srgb, var(--sp-accent), currentColor 10%);
    outline-offset: 2px;
  }
  .nav-item.active {
    background: color-mix(in srgb, var(--sp-accent), transparent 85%);
    border-left: 3px solid var(--sp-accent);
  }

  .ic {
    inline-size: 24px;
    block-size: 24px;
    display: grid;
    place-items: center;
    color: inherit; /* icons follow text color (SVG uses currentColor) */
  }
  .ic :global(svg) {
    display: block;
  }

  .lbl {
    font-weight: 200;
  }

  .badge {
    justify-self: end;
    font-size: 0.72rem;
    padding: 0.12rem 0.42rem;
    border-radius: 999px;
    background: color-mix(in srgb, var(--sp-fg), transparent 90%);
    border: 1px solid color-mix(in srgb, var(--sp-accent), transparent 70%);
    color: inherit;
  }

  /* ---------- Separators ---------- */
  .panel .p-nav hr,
  .panel .p-foot hr {
    border: 0;
    height: 1px;
    background: var(--sp-sep);
    opacity: 1;
    margin: 0.6rem 0.25rem;
    border-radius: 999px;
  }

  /* ---------- Footer ---------- */
  .p-foot {
    border-top: 1px solid var(--sp-sep);
    padding-top: 0.6rem;
    display: grid;
    gap: 0.25rem;
  }
</style>
