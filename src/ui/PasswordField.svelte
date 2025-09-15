<script>
  export let id = "password";
  export let label = "Password";
  export let value = "";
  export let placeholder = "";
  export let required = false;
  export let showMeter = false; // default off to match your working screen
  let show = false;

  $: score = strength(value);
  function strength(pwd) {
    const l = pwd.length,
      lo = /[a-z]/.test(pwd),
      up = /[A-Z]/.test(pwd),
      n = /\d/.test(pwd),
      s = /[^A-Za-z0-9]/.test(pwd);
    let k = 0;
    if (l >= 8) k++;
    if (l >= 12) k++;
    if (lo && up) k++;
    if (n) k++;
    if (s) k++;
    return {
      k,
      pct: Math.min(100, (k / 5) * 100),
      label:
        k >= 4 ? "Strong" : k === 3 ? "Good" : k === 2 ? "Weak" : "Very weak",
    };
  }
</script>

{#if label}<label for={id}>{label}</label>{/if}

{#if show}
  <input
    {id}
    type="text"
    bind:value
    {placeholder}
    {required}
    aria-describedby={showMeter ? `${id}-meter ${id}-hint` : null}
  />
{:else}
  <input
    {id}
    type="password"
    bind:value
    {placeholder}
    {required}
    aria-describedby={showMeter ? `${id}-meter ${id}-hint` : null}
  />
{/if}

<label class="label-inline">
  <input type="checkbox" bind:checked={show} />
  Show Password
</label>

{#if showMeter}
  <div
    id={`${id}-meter`}
    style="height:6px;background:var(--pico-muted-border-color);border-radius:999px;overflow:hidden;margin-top:.5rem;"
  >
    <div
      style={`height:100%;width:${score.pct}%;background:var(--pico-primary);`}
    ></div>
  </div>
  <small id={`${id}-hint`}
    >{score.label}. Use 12+ chars, mix case, numbers, symbol.</small
  >
{/if}
