<script>
  import { createEventDispatcher } from "svelte";
  import MenuButton from "./MenuButton.svelte";
  import USDNoteLogo from "./USDNoteLogo.svelte";
  const dispatch = createEventDispatcher(); /* NEW */

  export let logoHref = "/";
  export let isAuthed = false;

  export let menuExpanded = false;

  function openMenu() {
    dispatch("menu");
  } /* NEW */
</script>

<header class="bar container">
  <a class="brand" href={logoHref}>USDNote</a>

  <nav class="right">
    {#if isAuthed}
      <MenuButton
        tone="auto"
        controls="app-drawer"
        expanded={menuExpanded}
        on:click={openMenu}
      />
    {:else}
      <a href="/signup" role="button">Sign up</a>
      <a href="/login" role="button" class="contrast">Log in</a>
    {/if}
  </nav>
</header>

<style>
  .bar {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding-block: 0.75rem;
    border-bottom: 1px solid var(--pico-muted-border-color);
  }
  .brand {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
    font-weight: 600;
    font-size: 2rem;
    color: var(--brand-amber-800);
  }
  .right {
    margin-inline-start: auto;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
  }
</style>
