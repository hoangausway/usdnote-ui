<script>
  import "./router.js";
  import ThemeSwitcher from "./components/ThemeSwitcher.svelte";
</script>

<nav class="container-fluid" style="padding:.5rem 1rem;">
  <ul>
    <li><strong>USDNote</strong></li>
  </ul>
  <ul>
    <li><a href="/" data-navigo>Home</a></li>
    <li><a href="/playground" data-navigo>Playground</a></li>
    <li><ThemeSwitcher /></li>
  </ul>
</nav>

<main class="container" style="padding:1rem 0;">
  <div id="view"></div>
</main>
