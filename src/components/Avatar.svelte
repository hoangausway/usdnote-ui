<script>
  export let name = "";
  export let email = "";
  export let size = 36; // px

  function initials(n, e) {
    const base = (n && n.trim()) || (e && e.split("@")[0]) || "";
    const parts = base.toUpperCase().split(/\s+/).filter(Boolean);
    if (parts.length >= 2) return `${parts[0][0]}${parts[1][0]}`;
    const clean = base.replace(/[^A-Z0-9]/gi, "");
    return (clean.slice(0, 2) || "U").toUpperCase();
  }
</script>

<div class="avatar" style={`--size:${size}px`} aria-label={name || email}>
  {initials(name, email)}
</div>

<style>
  .avatar {
    inline-size: var(--size);
    block-size: var(--size);
    border-radius: 50%;
    display: grid;
    place-items: center;
    font-weight: 700;
    letter-spacing: 0.5px;
    background: color-mix(in srgb, var(--pico-primary), #000 5%);
    color: var(--pico-primary-inverse);
    user-select: none;
  }
</style>
