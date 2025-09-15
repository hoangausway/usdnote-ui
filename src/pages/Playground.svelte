<script>
  import Button from "../ui/Button.svelte";
  import Checkbox from "../ui/Checkbox.svelte";
  import TextField from "../ui/TextField.svelte";
  import ThemeSwitcher from "../components/ThemeSwitcher.svelte";

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

<ThemeSwitcher />
<section>
  <h2>UI Playground</h2>
  <p>Quickly test Pico styles, forms, and components (Amber + light/dark).</p>

  <!-- Buttons -->
  <article class="card">
    <h3>Buttons</h3>
    <div class="grid">
      <Button>Custom</Button>
      <Button>Default</Button>
      <Button class="secondary">Secondary</Button>
      <Button class="contrast">Contrast</Button>
      <Button disabled>Disabled</Button>
    </div>
  </article>

  <!-- Form -->
  <article class="card">
    <h3>Form</h3>
    <form on:submit={submit} style="max-width:520px;">
      <TextField
        id="email-login"
        label="Email"
        type="email"
        bind:value={email}
        required
      />

      <TextField
        id="amt"
        label="Amount"
        type="number"
        bind:value={amount}
        min="0"
        step="0.01"
        required
      />

      <div style="display:flex; gap:.75rem; margin-top:1rem;">
        <Button type="submit">Submit</Button>
        <Button
          type="button"
          class="secondary"
          on:click={() => {
            email = "";
            amount = 100;
          }}>Reset</Button
        >
      </div>
      <Checkbox id="chkbox">Show Password</Checkbox>
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
    <Button class="contrast" type="button" on:click={openDialog}
      >Open Modal</Button
    >
  </article>
</section>

<!-- Accessible native dialog (no click handlers on non-interactive elements) -->
<dialog bind:this={dialogEl}>
  <article>
    <header>
      <Button aria-label="Close" rel="prev" type="button" on:click={closeDialog}
      ></Button>
      <h3>Confirm</h3>
    </header>
    <p>
      Submit transaction for <strong>{email || "N/A"}</strong> —
      <strong>${amount}</strong>?
    </p>
    <footer>
      <Button class="secondary" type="button" on:click={closeDialog}
        >Cancel</Button
      >
      <Button type="button" on:click={closeDialog}>Confirm</Button>
    </footer>
  </article>
</dialog>
