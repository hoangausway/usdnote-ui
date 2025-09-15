<script>
  import { createEventDispatcher } from "svelte";
  import MenuButton from "./MenuButton.svelte";

  const dispatch = createEventDispatcher(); /* NEW */

  export let logoText = "USDNote";
  export let logoHref = "/";
  export let logoSrc = "";
  export let isAuthed = false;

  export let menuExpanded = false;

  function openMenu() {
    dispatch("menu");
  } /* NEW */
</script>

<header class="bar container">
  <a class="brand" href={logoHref}>
    {#if logoSrc}<img src={logoSrc} alt={`${logoText} logo`} /><span class="sr"
        >{logoText}</span
      >
    {:else}<strong>{logoText}</strong>{/if}
  </a>

  <nav class="right">
    <MenuButton
      tone="auto"
      controls="app-drawer"
      expanded={menuExpanded}
      on:click={openMenu}
    />
    {#if !isAuthed}
      <a href="/signup" role="button" class="contrast">Sign up</a>
      <a href="/login" role="button">Log in</a>
    {/if}
  </nav>
</header>

<style>
  .bar {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding-block: 0.75rem;
  }
  .brand {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
  }
  .brand img {
    height: 28px;
    width: auto;
    display: block;
  }
  .right {
    margin-inline-start: auto;
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
  }
  .icon.ghost {
    background: transparent;
    border: 1px solid var(--pico-muted-border-color);
    padding: 0.4rem 0.6rem;
    border-radius: 0.6rem;
  }
  .sr {
    position: absolute;
    inline-size: 1px;
    block-size: 1px;
    overflow: hidden;
    white-space: nowrap;
    clip: rect(0, 0, 0, 0);
  }
</style>
