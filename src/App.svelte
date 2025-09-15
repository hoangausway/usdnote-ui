<script>
  import "./router.js";
  import HeaderBar from "./components/HeaderBar.svelte";
  import BottomBar from "./components/BottomBar.svelte";
  import SidePanel from "./components/SidePanel.svelte";

  let drawerOpen = false; // NEW
  let isAuthed = true; // wire to your auth store later
  let user = { name: "Hoang Nguyen", email: "hoang@example.com" };
  const logoSrc = "/lockcoin.png";

  // Left panel nav — tweak as needed
  const navItems = [
    { label: "Dashboard", href: "/" },
    { label: "Deposit funds", href: "/deposit" },
    { label: "Wallets", href: "/wallets" },
    { label: "Buy / Sell", href: "/trade" },
    { label: "Swap", href: "/swap" },
    { label: "Bundles", href: "/bundles" },
    { label: "NFT", href: "/nft" },
    { label: "OTC", href: "/otc" },
    { label: "Markets", href: "/markets" },
    { separator: true },
    { label: "My account", href: "/account" },
    { separator: true },
    { label: "Logout", href: "/" },
  ];
</script>

<main class="pico">
  <HeaderBar
    {isAuthed}
    {user}
    {logoSrc}
    logoText="USDNote"
    menuExpanded={drawerOpen}
    on:menu={() => (drawerOpen = true)}
  />
  <section class="main container" style="padding:1rem 0;">
    <div id="view"></div>
  </section>

  <BottomBar />

  <!-- Drawer -->
  <SidePanel bind:open={drawerOpen} title="Menu" items={navItems} />
</main>
