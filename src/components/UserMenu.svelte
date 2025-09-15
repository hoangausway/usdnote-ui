<script>
  export let items = [
    { label: "Dashboard", href: "/dashboard" },
    { label: "Profile", href: "/profile" },
    { label: "Settings", href: "/settings" },
    { separator: true },
    { label: "Sign out", href: "/logout" }, // UI-only
  ];
  export let summary = "Menu";
</script>

<details class="dropdown">
  <summary class="secondary">{summary}</summary>
  <ul>
    {#each items as item}
      {#if item.separator}
        <li><hr /></li>
      {:else}
        <li><a href={item.href}>{item.label}</a></li>
      {/if}
    {/each}
  </ul>
</details>
