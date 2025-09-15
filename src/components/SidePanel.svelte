<script>
  import { onMount, onDestroy, tick } from "svelte";

  export let open = false; // bind:open from parent
  export let title = "Menu";
  export let items = []; // [{label, href} | {separator:true}]
  export let width = 320; // px

  let panel;
  let prevFocus;

  function close() {
    open = false;
  }
  function onKey(e) {
    if (open && e.key === "Escape") close();
  }

  async function focusFirst() {
    await tick();
    const first = panel?.querySelector(
      "a,button,[tabindex]:not([tabindex='-1'])"
    );
    first?.focus();
  }

  onMount(() => {
    const html = document.documentElement;
    const update = () => {
      if (open) {
        prevFocus = document.activeElement;
        html.classList.add("no-scroll");
        focusFirst();
      } else {
        html.classList.remove("no-scroll");
        prevFocus && prevFocus.focus?.();
      }
    };
    update();

    const mo = new MutationObserver(update);
    mo.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ["class"],
    });

    return () => {
      html.classList.remove("no-scroll");
      mo.disconnect();
    };
  });
</script>

<svelte:window on:keydown={onKey} />

{#if open}
  <button
    class="scrim"
    type="button"
    aria-label="Close menu"
    on:click={close}
  />
  <aside
    id="app-drawer"
    bind:this={panel}
    role="dialog"
    aria-modal="true"
    aria-label={title}
    class="panel"
    style={`--w:${width}px`}
  >
    <header class="p-head">
      <strong>{title}</strong>
      <button class="icon" aria-label="Close" on:click={close}>×</button>
    </header>

    <nav class="p-nav">
      {#each items as it}
        {#if it.separator}
          <hr />
        {:else}
          <a href={it.href} on:click={close}>{it.label}</a>
        {/if}
      {/each}
    </nav>
  </aside>
{/if}

<style>
  /* overlay */
  .scrim {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.45);
    backdrop-filter: blur(2px);
    z-index: 9998;
  }
  /* panel */
  .panel {
    position: fixed;
    inset-block: 0;
    inset-inline-start: 0;
    inline-size: min(var(--w), 86vw);
    background: #0c2b66; /* deep navy fallback */
    background: color-mix(in srgb, var(--pico-primary), #06225a 60%);
    color: #fff;
    z-index: 9999;
    padding: 1rem;
    display: grid;
    grid-template-rows: auto 1fr;
    animation: slideIn 0.18s ease-out;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
  }
  @keyframes slideIn {
    from {
      transform: translateX(-10%);
      opacity: 0.8;
    }
  }
  .p-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
  }
  .p-head .icon {
    background: transparent;
    border: 0;
    color: inherit;
    font-size: 1.5rem;
    line-height: 1;
    cursor: pointer;
    padding: 0.25rem 0.5rem;
  }
  .p-nav {
    display: grid;
    gap: 0.25rem;
    margin-top: 0.5rem;
  }
  .p-nav a {
    display: flex;
    align-items: center;
    gap: 0.6rem;
    color: #fff;
    text-decoration: none;
    padding: 0.75rem 0.25rem;
    border-radius: 0.5rem;
  }
  .p-nav a:hover {
    background: rgba(255, 255, 255, 0.08);
  }
  hr {
    border: 0;
    height: 1px;
    background: rgba(255, 255, 255, 0.2);
    margin: 0.5rem 0;
  }
</style>
