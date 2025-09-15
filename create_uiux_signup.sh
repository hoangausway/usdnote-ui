#!/usr/bin/env bash
set -euo pipefail

DEST="."
FORCE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dest) DEST="$2"; shift 2 ;;
    --force) FORCE=1; shift ;;
    *) echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

UI="$DEST/src/ui"
PAGES="$DEST/src/pages"
ROUTER="$DEST/src/router.js"

confirm_write() {
  local path="$1"
  if [[ -f "$path" && $FORCE -ne 1 ]]; then
    read -rp "File $path exists. Overwrite? [y/N] " ans
    [[ "$ans" =~ ^[Yy]$ ]] || return 1
  fi
  return 0
}

write_file() {
  local path="$1"
  shift
  confirm_write "$path" || { echo "Skipping $path"; return 0; }
  mkdir -p "$(dirname "$path")"
  # literal heredoc (no expansion)
  cat > "$path" <<'EOF'
'"$@"'
EOF
  # Replace the small wrapper with the actual literal content.
  # (We put the whole payload in $*, so rewrite the file plainly.)
  cat > "$path" <<EOF
$*
EOF
  echo "✅ Wrote $path"
}

# -----------------------------
# Create components & page
# -----------------------------
mkdir -p "$UI" "$PAGES"

# Button.svelte
write_file "$UI/Button.svelte" '<script>
  export let type = "button";
  export let variant = "primary"; // primary | outline | ghost
  export let disabled = false;
</script>

<button {type} disabled={disabled} class={`btn ${variant}`}> 
  <slot />
</button>

<style>
  .btn { 
    padding: .7rem 1rem; border-radius: 999px; font-weight: 600; 
    border: 1px solid transparent; cursor: pointer; transition: transform .05s ease;
  }
  .btn:active { transform: translateY(1px); }
  .btn[disabled] { opacity: .6; cursor: not-allowed; }
  .primary { background: var(--pico-primary); color: var(--pico-primary-inverse); }
  .outline { background: transparent; border-color: var(--pico-primary); color: var(--pico-primary); }
  .ghost { background: transparent; color: inherit; }
</style>
'

# TextField.svelte
write_file "$UI/TextField.svelte" '<script>
  export let id;
  export let label = "";
  export let type = "text"; // text | email | tel | password
  export let value = "";
  export let placeholder = "";
  export let autocomplete = undefined;
  export let required = false;
  export let invalid = false;
  export let hint = ""; // optional helper text
</script>

<div class="field">
  {#if label}<label for={id}>{label}</label>{/if}
  <input {id} {type} bind:value {placeholder} {autocomplete} {required}
         aria-invalid={invalid} aria-describedby={hint ? `${id}-hint` : null} />
  {#if hint}<small id={`${id}-hint`}>{hint}</small>{/if}
</div>

<style>
  .field { margin-bottom: var(--pico-spacing); }
  input[aria-invalid="true"] { outline: 2px solid var(--pico-del-color); }
</style>
'

# PasswordField.svelte
write_file "$UI/PasswordField.svelte" '<script>
  export let id = "password";
  export let label = "Password";
  export let value = "";
  export let placeholder = "";
  export let required = false;
  export let showMeter = true;
  let show = false;

  $: score = strength(value);
  function strength(pwd) {
    const l=pwd.length, lo=/[a-z]/.test(pwd), up=/[A-Z]/.test(pwd), n=/\d/.test(pwd), s=/[^A-Za-z0-9]/.test(pwd);
    let k=0; if(l>=8)k++; if(l>=12)k++; if(lo&&up)k++; if(n)k++; if(s)k++;
    return {k, pct: Math.min(100, (k/5)*100), label: k>=4?"Strong":k===3?"Good":k===2?"Weak":"Very weak"};
  }
</script>

<div class="field">
  <label for={id}>{label}</label>
  <div class="row">
    <input id={id} type={show ? "text" : "password"} bind:value {placeholder} {required}
           aria-describedby={showMeter ? `${id}-meter ${id}-hint` : null} />
    <button type="button" class="ghost" on:click={() => show = !show} aria-pressed={show}>
      {show ? "Hide" : "Show"}
    </button>
  </div>
  {#if showMeter}
    <div id={`${id}-meter`} class="meter"><div class="bar" style={`width:${score.pct}%`}></div></div>
    <small id={`${id}-hint`}>{score.label}. Use 12+ chars, mix case, numbers, symbol.</small>
  {/if}
</div>

<style>
  .row { display: grid; grid-template-columns: 1fr auto; gap: .5rem; align-items: center; }
  .ghost { background: transparent; border: 1px solid var(--pico-muted-border-color); padding: .55rem .8rem; border-radius: .7rem; }
  .meter { height: 6px; background: var(--pico-muted-border-color); border-radius: 999px; overflow: hidden; margin-top: .5rem; }
  .bar { height: 100%; background: var(--pico-primary); }
  .field { margin-bottom: var(--pico-spacing); }
</style>
'

# Checkbox.svelte
write_file "$UI/Checkbox.svelte" '<script>
  export let id;
  export let checked = false;
  export let label = "";
</script>
<label class="check">
  <input id={id} type="checkbox" bind:checked />
  <span><slot>{label}</slot></span>
</label>
<style>
  .check { display:flex; align-items:center; gap:.5rem; margin:.5rem 0 1rem; }
</style>
'

# FormRow.svelte
write_file "$UI/FormRow.svelte" '<script>
  export let columns = 1; // 1 | 2
</script>
<div class="row" class:two={columns===2}><slot /></div>
<style>
  .row { display:grid; grid-template-columns: 1fr; gap: var(--pico-spacing); }
  @media (min-width:640px){ .row.two { grid-template-columns: 1fr 1fr; } }
</style>
'

# PageHeader.svelte
write_file "$UI/PageHeader.svelte" '<script>
  export let title = "";
  export let subtitle = "";
</script>
<header class="ph">
  <h1>{title}</h1>
  {#if subtitle}<p class="muted">{subtitle}</p>{/if}
</header>
<style>
  .ph { margin: 1rem 0 1.5rem; }
  .muted { color: var(--pico-muted-color); }
</style>
'

# Toast.svelte
write_file "$UI/Toast.svelte" '<script>
  import { onMount } from "svelte";
  export let message = "";
  export let type = "info"; // info | success | error
  export let duration = 3000;
  let visible = false;
  let timer;

  onMount(() => {
    if (message) show();
  });

  function show() {
    visible = true;
    clearTimeout(timer);
    timer = setTimeout(() => (visible = false), duration);
  }

  $: if (message) show();
</script>

{#if visible}
  <aside class={`toast ${type}`} role="status">{message}</aside>
{/if}

<style>
  .toast {
    position: fixed;
    bottom: 1rem;
    right: 1rem;
    padding: 0.8rem 1.2rem;
    border-radius: .7rem;
    background: var(--pico-card-background-color);
    box-shadow: var(--pico-shadow);
    z-index: 1000;
  }
  .toast.info { border-left: 4px solid var(--pico-primary); }
  .toast.success { border-left: 4px solid var(--pico-secondary); }
  .toast.error { border-left: 4px solid var(--pico-del-color); }
</style>
'

# pages/Signup.svelte
write_file "$PAGES/Signup.svelte" '<script>
  import PageHeader from "../ui/PageHeader.svelte";
  import FormRow from "../ui/FormRow.svelte";
  import TextField from "../ui/TextField.svelte";
  import PasswordField from "../ui/PasswordField.svelte";
  import Checkbox from "../ui/Checkbox.svelte";
  import Button from "../ui/Button.svelte";
  import Toast from "../ui/Toast.svelte";

  // Local state (demo only)
  let firstName = "";
  let lastName = "";
  let phone = "";
  let email = "";
  let email2 = "";
  let pwd = "";
  let pwd2 = "";
  let agree = false;
  let toastMessage = "";
  let toastType = "info";

  // Light UX-only checks (no API)
  $: emailMatch = email && email2 && email.trim().toLowerCase() === email2.trim().toLowerCase();
  $: pwdMatch = pwd && pwd2 && pwd === pwd2;

  function handleSubmit(e){
    e.preventDefault();
    // ACTION PLACEHOLDER — no real call; simulate UX only
    console.log("[UIUX] submit", { firstName, lastName, phone, email, pwd, agree });
    toastMessage = "Account created (demo)!";
    toastType = "success";
  }
</script>

<PageHeader title="Create your Lockcoin account" subtitle="UI/UX playground — no real signup" />

<main class="container">
  <form on:submit={handleSubmit} novalidate>
    <FormRow columns={2}>
      <TextField id="first" label="First name" bind:value={firstName} required autocomplete="given-name" />
      <TextField id="last" label="Last name" bind:value={lastName} required autocomplete="family-name" />
    </FormRow>

    <TextField id="phone" label="Phone (optional)" type="tel" bind:value={phone} placeholder="e.g. +61 4xx xxx xxx" autocomplete="tel" />

    <TextField id="email" label="Email" type="email" bind:value={email} required autocomplete="email" />
    <TextField id="email2" label="Confirm email" type="email" bind:value={email2} required invalid={email && email2 && !emailMatch} hint={!emailMatch && email && email2 ? "Emails do not match" : ""} />

    <PasswordField id="pwd" label="Password" bind:value={pwd} />
    <TextField id="pwd2" label="Confirm password" type="password" bind:value={pwd2} required invalid={pwd && pwd2 && !pwdMatch} hint={!pwdMatch && pwd && pwd2 ? "Passwords do not match" : ""} />

    <Checkbox id="agree" bind:checked={agree}>
      I agree to the <a href="#">Terms</a> and <a href="#">Privacy Policy</a>.
    </Checkbox>

    <Button type="submit">Create account</Button>

    <p class="helper"><small>Already have an account? <a href="#">Log in</a>.</small></p>
  </form>

  <Toast message={toastMessage} type={toastType} />
</main>

<style>
  .container { max-width: 720px; margin-inline: auto; }
  .helper { margin-top: .75rem; }
</style>
'

# -----------------------------
# Patch or create src/router.js to include /signup
# -----------------------------
if [[ -f "$ROUTER" ]]; then
  # ensure imports exist at the top
  TMP="$ROUTER.tmp1"
  {
    if ! grep -q 'import page from "page";' "$ROUTER"; then
      echo 'import page from "page";'
    fi
    if ! grep -q 'import Signup from "./pages/Signup.svelte";' "$ROUTER"; then
      echo 'import Signup from "./pages/Signup.svelte";'
    fi
    cat "$ROUTER"
  } > "$TMP"
  mv "$TMP" "$ROUTER"

  # ensure mount() exists
  if ! grep -q 'function mount(' "$ROUTER"; then
    TMP="$ROUTER.tmp2"
    {
      echo
      echo 'function mount(component, props = {}) {'
      echo '  const target = document.getElementById("app");'
      echo '  new component({ target, props });'
      echo '}'
      cat "$ROUTER"
    } > "$TMP"
    mv "$TMP" "$ROUTER"
  fi

  # insert route before first "page();" if present; else append route + page()
  if grep -q '^page();' "$ROUTER"; then
    awk 'BEGIN{done=0} 
      /^page\(\);$/ && !done { print "page(\"/signup\", () => mount(Signup));"; done=1 } 
      { print }' "$ROUTER" > "$ROUTER.tmp3"
    mv "$ROUTER.tmp3" "$ROUTER"
  else
    echo 'page("/signup", () => mount(Signup));' >> "$ROUTER"
    echo 'page();' >> "$ROUTER"
  fi
  echo "✅ Patched $ROUTER (added /signup)"
else
  # create a minimal router
  cat > "$ROUTER" <<'EOF'
import page from "page";
import Signup from "./pages/Signup.svelte";

function mount(component, props = {}) {
  const target = document.getElementById("app");
  new component({ target, props });
}

// Add more routes as needed, e.g.:
// import Home from "./pages/Home.svelte";
// page("/", () => mount(Home));

page("/signup", () => mount(Signup));
page();
EOF
  echo "✅ Created $ROUTER"
fi

echo
echo "🎉 Done. Start your dev server and open /signup"
