<footer class="bottom container">
  <small>© {new Date().getFullYear()} USDNote</small>
  <span class="spacer"></span>
  <nav>
    <a href="/privacy">Privacy</a>
    <a href="/terms">Terms</a>
  </nav>
</footer>

<style>
  .bottom {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    padding-block: 1rem;
    border-top: 1px solid var(--pico-muted-border-color);
    margin-top: 2rem;
  }
  .bottom nav {
    display: inline-flex;
    gap: 0.75rem;
  }
  .spacer {
    margin-inline-start: auto;
  }
</style>
