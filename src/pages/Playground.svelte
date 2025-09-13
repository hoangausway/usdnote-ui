<script>
  let dialogEl;
  let email = "";
  let amount = 100;
  let open = false;

  function submit(e) {
    e.preventDefault();
    openDialog();
  }

  function openDialog() {
    open = true;
    dialogEl?.showModal();
  }

  function closeDialog() {
    open = false;
    dialogEl?.close();
  }
</script>

<section>
  <h2>UI Playground</h2>
  <p>Quickly test Pico styles, forms, and components (Amber + light/dark).</p>

  <!-- Buttons -->
  <article class="card">
    <h3>Buttons</h3>
    <div class="grid">
      <button>Default</button>
      <button class="secondary">Secondary</button>
      <button class="contrast">Contrast</button>
      <button disabled>Disabled</button>
    </div>
  </article>

  <!-- Form -->
  <article class="card">
    <h3>Form</h3>
    <form on:submit={submit} style="max-width:520px;">
      <div class="grid">
        <label>Email <input type="email" bind:value={email} required /></label>
        <label
          >Amount <input
            type="number"
            min="0"
            step="0.01"
            bind:value={amount}
          /></label
        >
      </div>

      <div style="display:flex; gap:.75rem; margin-top:1rem;">
        <button type="submit">Submit</button>
        <button
          type="button"
          class="secondary"
          on:click={() => {
            email = "";
            amount = 100;
          }}>Reset</button
        >
      </div>
    </form>
  </article>

  <!-- Misc -->
  <article class="card">
    <h3>Misc</h3>
    <progress value="40" max="100"></progress>
    <details>
      <summary>Accordion</summary>
      <p>Pico’s defaults look clean with minimal markup.</p>
    </details>
  </article>

  <!-- Modal trigger -->
  <article class="card">
    <h3>Modal</h3>
    <button class="contrast" type="button" on:click={openDialog}
      >Open Modal</button
    >
  </article>
</section>

<!-- Accessible native dialog (no click handlers on non-interactive elements) -->
<dialog bind:this={dialogEl}>
  <article>
    <header>
      <button aria-label="Close" rel="prev" type="button" on:click={closeDialog}
      ></button>
      <h3>Confirm</h3>
    </header>
    <p>
      Submit transaction for <strong>{email || "N/A"}</strong> —
      <strong>${amount}</strong>?
    </p>
    <footer>
      <button class="secondary" type="button" on:click={closeDialog}
        >Cancel</button
      >
      <button type="button" on:click={closeDialog}>Confirm</button>
    </footer>
  </article>
</dialog>
