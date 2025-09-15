<script>
  import { onMount } from "svelte";
  export let message = "";
  export let type = "info"; // info | success | error
  export let duration = 3000;
  let visible = false;
  let timer;

  onMount(() => {
    if (message) show();
  });

  function show() {
    visible = true;
    clearTimeout(timer);
    timer = setTimeout(() => (visible = false), duration);
  }

  $: if (message) show();
</script>

{#if visible}
  <aside class={`toast ${type}`} role="status" aria-live="polite">
    {message}
  </aside>
{/if}

<style>
  .toast {
    position: fixed;
    bottom: 1rem;
    right: 1rem;
    padding: 0.8rem 1.2rem;
    border-radius: 0.7rem;
    background: var(--pico-card-background-color);
    box-shadow: var(--pico-shadow);
    z-index: 1000;
  }
  .toast.info {
    border-left: 4px solid var(--pico-primary);
  }
  .toast.success {
    border-left: 4px solid var(--pico-secondary);
  }
  .toast.error {
    border-left: 4px solid var(--pico-del-color);
  }
</style>
