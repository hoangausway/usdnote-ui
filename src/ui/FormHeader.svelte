<script>
  export let title = "";
  export let subtitle = "";
</script>

<div class="ph">
  <h1>{title}</h1>
  {#if subtitle}<p class="muted">{subtitle}</p>{/if}
</div>

<style>
  .ph {
    margin: 1rem 0 1.5rem;
  }
  .muted {
    color: var(--pico-muted-color);
    font-size: 0.9rem;
    margin-top: -1rem;
  }
</style>
