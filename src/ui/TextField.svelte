<script>
  export let id;
  export let label = "";
  export let type = "text"; // "text" | "email" | "tel" | "password" | "number"
  export let value = ""; // if you want numeric binding, see valueAsNumber below
  export let placeholder = "";
  export let autocomplete = undefined;
  export let required = false;
  export let invalid = false;
  export let hint = "";

  // Number-only helpers (optional)
  export let min = undefined;
  export let max = undefined;
  export let step = undefined;
  export let valueAsNumber = false; // set true to coerce to a Number
  export let inputmode = undefined; // e.g. "decimal" or "numeric" to hint mobile keyboard

  function onNumberInput(e) {
    if (!valueAsNumber) return;
    const n = e.currentTarget.valueAsNumber;
    // When the field is empty, valueAsNumber is NaN — keep it as "" for nicer UX
    value = Number.isNaN(n) ? "" : n;
  }
</script>

{#if label}<label for={id}>{label}</label>{/if}

{#if type === "email"}
  <input
    {id}
    type="email"
    bind:value
    {placeholder}
    {autocomplete}
    {required}
    aria-invalid={invalid}
    aria-describedby={hint ? `${id}-hint` : null}
  />
{:else if type === "tel"}
  <input
    {id}
    type="tel"
    bind:value
    {placeholder}
    {autocomplete}
    {required}
    aria-invalid={invalid}
    aria-describedby={hint ? `${id}-hint` : null}
  />
{:else if type === "password"}
  <input
    {id}
    type="password"
    bind:value
    {placeholder}
    {autocomplete}
    {required}
    aria-invalid={invalid}
    aria-describedby={hint ? `${id}-hint` : null}
  />
{:else if type === "number"}
  <input
    {id}
    type="number"
    bind:value
    {placeholder}
    {required}
    {min}
    {max}
    {step}
    {inputmode}
    on:input={onNumberInput}
    aria-invalid={invalid}
    aria-describedby={hint ? `${id}-hint` : null}
  />
{:else}
  <input
    {id}
    type="text"
    bind:value
    {placeholder}
    {autocomplete}
    {required}
    aria-invalid={invalid}
    aria-describedby={hint ? `${id}-hint` : null}
  />
{/if}

{#if hint}<small id={`${id}-hint`}>{hint}</small>{/if}
