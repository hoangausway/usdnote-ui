<!-- GetStartButton.svelte -->
<script>
  import page from "page";
  function handleClick() {
    page("/signup");
  }
</script>

<button class="getstart" on:click={handleClick}> Get Start </button>

<style>
  .getstart {
    border: none;
    width: 8rem;
    padding: 0.75rem 1rem;
    border-radius: 6px;
    background: var(--brand-amber-800);
    color: whitesmoke;
    font-weight: 600;
    cursor: pointer;
    transition: background 0.2s ease;
  }
  .getstart:hover {
    background: var(--brand-amber-600);
  }
</style>
