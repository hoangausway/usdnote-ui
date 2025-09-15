<script>
  // A11y-friendly hamburger button with good contrast in light/dark.
  import { createEventDispatcher } from "svelte";
  const dispatch = createEventDispatcher(); /* NEW */

  // Props
  export let expanded = false; // reflect drawer state
  export let controls = undefined; // id of the drawer element
  export let tone = "auto"; // "auto" | "brand" | "inverse"
  export let size = 44; // tap target (px)
  export let labelOpen = "Open menu";
  export let labelClose = "Close menu";

  // choose foreground color based on tone
  $: fg =
    tone === "brand"
      ? "var(--pico-primary)"
      : tone === "inverse"
        ? "var(--pico-primary-inverse)"
        : "var(--pico-text-color)"; // default: high-contrast text

  $: ariaLabel = expanded ? labelClose : labelOpen;

  function handleClick() {
    // forward a 'click' event so <MenuButton on:click={...}/> works
    dispatch("click");
  }
</script>

<button
  type="button"
  class="menu-btn"
  aria-label={ariaLabel}
  aria-controls={controls}
  aria-expanded={expanded}
  style={`--mb-size:${size}px; --mb-fg:${fg};`}
  on:click={handleClick}
  {...$$restProps}
>
  {#if expanded}
    <!-- close (X) icon -->
    <svg
      width="22"
      height="22"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
    >
      <path d="M18 6L6 18M6 6l12 12" />
    </svg>
  {:else}
    <!-- hamburger icon -->
    <svg
      width="22"
      height="22"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
    >
      <path d="M3 6h18M3 12h18M3 18h18" />
    </svg>
  {/if}
</button>

<style>
  .menu-btn {
    /* visual */
    color: var(--mb-fg);
    background: transparent;
    border: 1px solid color-mix(in srgb, var(--mb-fg), transparent 70%);
    border-radius: 0.6rem;

    /* layout & ergonomics */
    min-inline-size: var(--mb-size);
    min-block-size: 40px;
    display: inline-grid;
    place-items: center;
    cursor: pointer;
  }

  .menu-btn:hover {
    background: color-mix(in srgb, var(--mb-fg), transparent 92%);
  }

  .menu-btn:focus-visible {
    outline: 2px solid var(--pico-primary-focus);
    outline-offset: 2px;
  }

  .menu-btn[disabled] {
    opacity: 0.6;
    cursor: not-allowed;
  }
</style>
