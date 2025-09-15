<script>
  import FormHeader from "../ui/FormHeader.svelte";
  import TextField from "../ui/TextField.svelte";
  import PasswordField from "../ui/PasswordField.svelte";
  import Checkbox from "../ui/Checkbox.svelte";
  import Button from "../ui/Button.svelte";
  import Toast from "../ui/Toast.svelte";

  let firstName = "";
  let lastName = "";
  let phone = "";
  let email = "";
  let email2 = "";
  let pwd = "";
  let pwd2 = "";
  let showPwd = false; // mirrors your working page's "Show Password"
  let isSubmitting = false;

  let toastMessage = "";
  let toastType = "info";

  $: emailMatch =
    email &&
    email2 &&
    email.trim().toLowerCase() === email2.trim().toLowerCase();
  $: pwdMatch = pwd && pwd2 && pwd === pwd2;

  function handleSubmit(e) {
    e.preventDefault();

    if (!email || !pwd || !firstName || !lastName) {
      toastMessage = "Please fill all required fields";
      toastType = "error";
      return;
    }
    if (!emailMatch) {
      toastMessage = "Email fields do not match";
      toastType = "error";
      return;
    }
    if (!pwdMatch) {
      toastMessage = "Password fields do not match";
      toastType = "error";
      return;
    }

    // UI-only submit
    isSubmitting = true;
    setTimeout(() => {
      isSubmitting = false;
      toastMessage = "Account created (demo)!";
      toastType = "success";
    }, 600);
  }
</script>

<article>
  <header>
    <FormHeader title="Sign Up" />
  </header>

  <form on:submit={handleSubmit} novalidate>
    <TextField
      id="first-name"
      label="First Name"
      bind:value={firstName}
      required
    />
    <TextField
      id="last-name"
      label="Last Name"
      bind:value={lastName}
      required
    />

    <TextField
      id="phone-number"
      label="Phone Number"
      type="tel"
      bind:value={phone}
    />

    <TextField
      id="email-signup"
      label="Email"
      type="email"
      bind:value={email}
      required
    />
    <TextField
      id="confirm-email-signup"
      label="Confirm Email"
      type="email"
      bind:value={email2}
      required
      invalid={email && email2 && !emailMatch}
      hint={!emailMatch && email && email2 ? "Emails do not match" : ""}
    />

    <!-- Password + confirm (toggle show like your working page) -->
    {#if showPwd}
      <TextField
        id="password-signup"
        label="Password"
        type="text"
        bind:value={pwd}
        required
      />
      <TextField
        id="confirm-password-signup"
        label="Confirm Password"
        type="text"
        bind:value={pwd2}
        required
        invalid={pwd && pwd2 && !pwdMatch}
        hint={!pwdMatch && pwd && pwd2 ? "Passwords do not match" : ""}
      />
    {:else}
      <TextField
        id="password-signup"
        label="Password"
        type="password"
        bind:value={pwd}
        required
      />
      <TextField
        id="confirm-password-signup"
        label="Confirm Password"
        type="password"
        bind:value={pwd2}
        required
        invalid={pwd && pwd2 && !pwdMatch}
        hint={!pwdMatch && pwd && pwd2 ? "Passwords do not match" : ""}
      />
    {/if}

    <Checkbox id="show-pwd" bind:checked={showPwd}>Show Password</Checkbox>

    <Button
      type="submit"
      disabled={isSubmitting}
      aria-busy={isSubmitting ? "true" : "false"}
    >
      {isSubmitting ? "Signing up..." : "Sign Up"}
    </Button>

    <p>Already have account? <a href="/login">Log in</a></p>
  </form>

  <Toast message={toastMessage} type={toastType} />
</article>
