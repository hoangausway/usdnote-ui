<script>
  import "./router.js";
  import HeaderBar from "./components/HeaderBar.svelte";
  import BottomBar from "./components/BottomBar.svelte";
  import SidePanel from "./components/SidePanel.svelte";
  import { isAuthed } from "./stores/auth.js";

  let user = { name: "Hoang Nguyen", email: "hoang@example.com" };

  let drawerOpen = false; // NEW

  // Left panel nav — tweak as needed
  const items = [
    { label: "Dashboard", href: "/dashboard", icon: "home" },
    { label: "Activities", href: "/activities", icon: "market" },
    { label: "Buy Coins", href: "/buy", icon: "trade" },
    { label: "Send Coins", href: "/send", icon: "arrow" },
    { label: "Redeem Coins", href: "/redeem", icon: "plus" },
    { label: "Set Wallet Keys", href: "/walletkey", icon: "settings" },
  ];
  const footerItems = [
    { label: "Settings", href: "/settings", icon: "settings" },
    { label: "Help", href: "/help", icon: "help" },
    { label: "Sign out", href: "/logout", icon: "logout" },
  ];
</script>

<main class="pico">
  <HeaderBar
    isAuthed={$isAuthed}
    menuExpanded={drawerOpen}
    on:menu={() => (drawerOpen = true)}
  />
  <section class="main container" style="padding:1rem 0;">
    <div id="view"></div>
  </section>

  <BottomBar />

  <!-- Drawer -->
  <!-- <SidePanel bind:open={drawerOpen} title="Menu" items={navItems} /> -->
  <SidePanel
    bind:open={drawerOpen}
    title="USDNote™"
    {items}
    {footerItems}
    {user}
  />
</main>
