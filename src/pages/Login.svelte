<script>
  import FormHeader from "../ui/FormHeader.svelte";
  import TextField from "../ui/TextField.svelte";
  import Checkbox from "../ui/Checkbox.svelte";
  import Button from "../ui/Button.svelte";
  import Toast from "../ui/Toast.svelte";
  import { login } from "../stores/auth.js";
  import page from "page"; // ✅ ADD THIS

  let email = "";
  let pwd = "";
  let showPwd = false;
  let remember = false;
  let isSubmitting = false;

  let toastMessage = "";
  let toastType = "info";

  function handleSubmit(e) {
    e.preventDefault();

    if (!email || !pwd) {
      toastMessage = "Please enter your email and password";
      toastType = "error";
      return;
    }

    // UI-only submit simulation
    isSubmitting = true;
    setTimeout(() => {
      isSubmitting = false;
      toastMessage = `Logged in (demo)${remember ? " — Remembered" : ""}`;
      toastType = "success";
      login(); // ✅ set isAuthed = true
      page("/dashboard"); // ✅ redirect
    }, 600);
  }
</script>

<article>
  <header class="form-header">
    <FormHeader title="Log In" />
  </header>

  <form on:submit={handleSubmit} novalidate>
    <TextField
      id="email-login"
      label="Email"
      type="email"
      bind:value={email}
      required
    />

    {#if showPwd}
      <TextField
        id="password-login"
        label="Password"
        type="text"
        bind:value={pwd}
        required
      />
    {:else}
      <TextField
        id="password-login"
        label="Password"
        type="password"
        bind:value={pwd}
        required
      />
    {/if}

    <Checkbox id="show-pwd" bind:checked={showPwd}>Show Password</Checkbox>

    <Button
      type="submit"
      disabled={isSubmitting}
      aria-busy={isSubmitting ? "true" : "false"}
    >
      {isSubmitting ? "Logging in..." : "Log In"}
    </Button>

    <p>
      Don’t have an account? <a href="/signup">Sign up</a>
      &nbsp;·&nbsp;
      <a href="/forgot-password">Forgot password?</a>
    </p>
  </form>

  <Toast message={toastMessage} type={toastType} />
</article>
