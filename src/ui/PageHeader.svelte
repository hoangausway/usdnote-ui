<script>
  export let title = "";
  export let subtitle = "";
</script>

<header class="ph">
  <h1>{title}</h1>
  {#if subtitle}<p class="muted">{subtitle}</p>{/if}
</header>

<style>
  .ph {
    margin: 1rem 0 1.5rem;
  }
  .muted {
    color: var(--pico-muted-color);
  }
</style>
