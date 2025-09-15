<script>
  export let type = "button";
  export let disabled = false;
  // optional visual variant; keep or ignore in your CSS
  export let variant = ""; // "primary" | "outline" | "ghost" | ""
</script>

<button
  {type}
  {disabled}
  class={`btn${variant ? ` ${variant}` : ""}`}
  {...$$restProps}
>
  <slot />
</button>

<style>
  /* Keep minimal so your form.css controls layout (e.g., width:100%) */
  .btn:active {
    transform: translateY(1px);
  }
  .btn[disabled] {
    opacity: 0.6;
    cursor: not-allowed;
  }
  /* optional variants if you use them */
  .primary {
    background: var(--pico-primary);
    color: var(--pico-primary-inverse);
  }
  .outline {
    background: transparent;
    border-color: var(--pico-primary);
    color: var(--pico-primary);
  }
  .ghost {
    background: transparent;
    color: inherit;
  }
</style>
