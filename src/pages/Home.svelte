<script>
  import bgSvg from "../assets/xsync.svg";
  import bgVideo from "../assets/bg.mp4";
  import Typewriter from "../components/Typewriter.svelte";
  import GetStartButton from "../components/GetStartButton.svelte";

  let showButton = false;

  export let rightTopImage =
    "https://images01.nicepage.com/c461c07a441a5d220e8feb1a/8d0c62508a53506da5f8966f/FDSF.jpg";
  export let leftImage =
    "https://images01.nicepage.com/c461c07a441a5d220e8feb1a/e76b5b7b20de5ea0ac53c38a/bitcoin-pile-top-dolar-bills_23-2148285293.jpg";
</script>

<!-- Decorative amber band -->
<div class="band" aria-hidden="true"></div>

<main class="container" style={`--bg:url(${bgSvg})`}>
  <!-- Hero with typewriter headline -->
  <section class="hero">
    <article class="card card--headline">
      <Typewriter
        text="USDNote™ — the easiest way to access and earn from U.S. Treasuries"
        speed={60}
        on:start={() => (showButton = false)}
        on:done={() => (showButton = true)}
      />
      {#if showButton}
        <div class="action">
          <GetStartButton />
        </div>
      {/if}
    </article>

    <figure class="media-left">
      <img src={leftImage} alt="Bitcoin on dollar bills" />
    </figure>
  </section>

  <!-- Tip: what is USDNote -->
  <article class="card card--tip">
    <ul>
      <li>USDNote = tokenized note backed 1:1 by U.S. Treasuries + cash.</li>
      <li>Distributes Treasury yield back to holders.</li>
      <li>
        Powered by the Lockcoin Microchain patent → faster, more private, more
        auditable than blockchain.
      </li>
    </ul>
  </article>

  <!-- Right decorative image -->
  <div
    class="media-right"
    style={`--img:url(${rightTopImage})`}
    aria-hidden="true"
  ></div>

  <!-- Lifecycle -->
  <article class="card card--tip">
    <header><h3>Lifecycle of a USDNote™</h3></header>
    {#each [{ title: "Buy / Issue", body: "User sends USD (via bank transfer, on-ramp, or licensed partner). Issuer buys short-term Treasuries. New USDNotes are minted and credited to the wallet. Each coin carries a lock + key." }, { title: "Hold / Earn", body: "While holding, Treasuries generate yield. Periodically, 90% is distributed to holders in new USDNotes ('dividend coins'); 10% retained for expenses." }, { title: "Transfer", body: "Two modes: Cash-like (private, instant, no receipt). Check-like (signed with key, creates auditable receipt). Transfers are validated by locks." }, { title: "Redeem", body: "Holder returns USDNotes to issuer. Issuer sells Treasuries (or uses cash buffer). User gets USD 1:1. Redeemed coins are burned." }] as step}
      <article class="cardstep">
        <h6>{step.title}</h6>
        <p>{step.body}</p>
      </article>
    {/each}
  </article>

  <!-- Why USDNote -->
  <article class="card card--tip">
    <header><h3>Why USDNote™?</h3></header>
    <ul>
      <li><strong>Sustainable</strong> — no mining, no energy waste.</li>
      <li><strong>Scalable</strong> — millions of transactions per second.</li>
      <li><strong>Secure</strong> — fraud alerts + time-delay safety.</li>
      <li>
        <strong>Secrecy</strong> — anonymity (cash-like) or protected receipts (check-like).
      </li>
      <li><strong>Speed</strong> — milliseconds to finality.</li>
    </ul>
  </article>

  <!-- Background video hero -->
  <section class="hihero">
    <video autoplay muted loop playsinline class="bg-video">
      <source src={bgVideo} type="video/mp4" />
    </video>
    <div class="hihero-content">
      <h1>USDNote™</h1>
      <p>Dividend-paying stablecoin backed by U.S. Treasuries.</p>
      <GetStartButton />
    </div>
  </section>
</main>

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <div class="footer-grid">
      {#each Array(3) as _}
        <section>
          <h6>Headline</h6>
          <p class="muted">Sample footer text</p>
        </section>
      {/each}
    </div>
  </div>
</footer>

<style>
  :root {
    --r: 6px;
    --veil: color-mix(in srgb, #fff 70%, transparent);
    --fr-color: black;
    --bg-color: whitesmoke;
    --bg-article-header: transparent;
    --fr-article-header: var(--fr-color);
    background-color: var(--bg-color);
  }
  .container {
    max-width: min(100%, 1140px);
    padding-inline: clamp(16px, 3vw, 28px);
    position: relative;
  }

  main.container {
    background-color: var(--bg-color);
  }
  main.container::before {
    content: "";
    position: absolute;
    inset: 0;
    background-image: var(--bg);
    background-repeat: no-repeat;
    background-position: top;
    transform: rotate(15deg);
    transform-origin: top;
    opacity: 0.15;
    z-index: 0;
    pointer-events: none;
  }
  main.container > * {
    position: relative;
    z-index: 1;
  }

  .band {
    margin-top: 2.5rem;
    height: 64px;
    background: var(--brand-jade-600);
  }

  /* Hero */
  .hero {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: clamp(16px, 2.5vw, 24px);
    margin-top: -120px;
    align-items: start;
  }
  @media (max-width: 991px) {
    .hero {
      grid-template-columns: 1fr;
      margin-top: -100px;
    }
  }

  /* Cards */
  article header h3 {
    color: var(--fr-article-header);
  }
  .card {
    background: #fff;
    border-radius: var(--r);
    padding: 24px 36px;
  }
  .card--headline {
    background: var(--brand-jade-100);
    box-shadow: 0 10px 28px rgba(0, 0, 0, 0.3);
  }
  .card--tip header {
    background-color: var(--bg-article-header);
    padding-top: 1.5rem;
  }
  .card--tip {
    border: 1px solid var(--deco-border-amber);
  }
  .card--tip li {
    color: var(--fr-color);
  }
  .cardstep {
    background-color: var(--bg-article-header);
  }
  .cardstep h6 {
    color: var(--brand-jade-800);
  }
  .cardstep p {
    color: var(--brand-jade-900);
  }

  /* Media */
  .media-left img {
    width: 100%;
    height: auto;
    border-radius: var(--r);
    object-fit: cover;
  }
  .media-right {
    min-height: 360px;
    border-radius: var(--r);
    border: 1px solid var(--deco-border-amber);
    background: center/cover no-repeat var(--veil);
    background-image: var(--img);
  }

  /* Action area */
  .action {
    margin-top: 2rem;
    display: flex;
    justify-content: flex-start;
  }

  /* Video hero */
  .hihero {
    position: relative;
    min-height: 60vh;
    overflow: hidden;
  }
  .bg-video {
    position: absolute;
    inset: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: -1;
  }
  .hihero-content {
    position: absolute;
    right: 1.5rem;
    bottom: 1.5rem;
    max-width: 400px;
    text-align: right;
  }
  .hihero-content h1 {
    color: var(--brand-jade-100);
  }
  .hihero-content p {
    color: white;
  }

  /* Footer */
  .footer {
    border-top: 1px solid var(--pico-muted-border-color);
    padding: 28px 0;
    margin-top: 32px;
    background: var(--brand-jade-100);
  }
  .footer-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 1.25rem;
  }
  @media (max-width: 991px) {
    .footer-grid {
      grid-template-columns: 1fr;
    }
  }
  .muted {
    color: #61706b;
  }
</style>
