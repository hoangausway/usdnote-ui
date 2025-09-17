<script>
  import "./router.js";
  import HeaderBar from "./components/HeaderBar.svelte";
  import BottomBar from "./components/BottomBar.svelte";
  import SidePanel from "./components/SidePanel.svelte";
  import { isAuthed } from "./stores/auth.js";

  let user = { name: "Hoang Nguyen", email: "hoang@example.com" };

  let drawerOpen = false; // NEW
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
  <SidePanel bind:open={drawerOpen} title="USDNote™" {user} />
</main>
