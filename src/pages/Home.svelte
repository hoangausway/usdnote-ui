<script>
  // Smooth-scroll helper for in-page anchors
  function go(id) {
    const el = document.getElementById(id);
    if (el) el.scrollIntoView({ behavior: "smooth", block: "start" });
  }
</script>

<!-- Hero -->
<section class="hero container">
  <div class="hero-art" aria-hidden="true">
    <!-- Animated “coins” -->
    <svg class="coin c1" viewBox="0 0 64 64" role="img" aria-label="USD coin">
      <circle cx="32" cy="32" r="30" class="coin-bg" />
      <text x="50%" y="52%" text-anchor="middle" class="coin-txt">$</text>
    </svg>
    <svg class="coin c2" viewBox="0 0 64 64" role="img" aria-label="Lock coin">
      <circle cx="32" cy="32" r="30" class="coin-bg" />
      <path d="M22 32h20v14H22z M26 32v-6a6 6 0 0 1 12 0v6" class="lock" />
    </svg>
    <svg class="coin c3" viewBox="0 0 64 64" role="img" aria-label="Microchain">
      <circle cx="20" cy="32" r="6" class="node" />
      <circle cx="44" cy="20" r="6" class="node" />
      <circle cx="44" cy="44" r="6" class="node" />
      <path d="M25 30 L39 22 M25 34 L39 42" class="edge" />
    </svg>
  </div>

  <div class="hero-copy">
    <h1>USDNote™ & LockCoin™ Technology</h1>
    <p class="lead">
      Dividend-paying stablecoin + fractional investment rails—powered by
      <em>Microchains™</em> for fast, private, auditable transfers.
    </p>
    <div class="cta">
      <a href="/signup" role="button" class="primary">Get started</a>
      <button class="contrast outline" on:click={() => go("usdnote")}
        >Learn more</button
      >
    </div>
    <p class="microcopy">
      Not financial advice. Product availability may vary by jurisdiction.
    </p>
  </div>
</section>

<!-- Section: USDNote -->
<section id="usdnote" class="container">
  <article class="card reveal">
    <header>
      <h2>1. USDNote™ — A Dividend-Paying Stablecoin</h2>
      <p class="muted">
        A USD-linked note backed by U.S. Treasuries; interest is distributed as
        dividends.
      </p>
    </header>

    <div class="grid cols-illustration">
      <div>
        <h3>Strengths</h3>
        <ul>
          <li>
            <strong>Treasury-backed yield</strong> → dividends from interest on U.S.
            Treasuries.
          </li>
          <li>
            <strong>First of its kind</strong> among mainstream stablecoin models.
          </li>
          <li>
            <strong>LockCoin™ Microchains™</strong> for high-throughput transactions.
          </li>
          <li>
            <strong>Anonymous dividend distribution</strong> with compliance alignment.
          </li>
          <li><strong>Easy entry</strong> — email or phone onboarding.</li>
          <li>
            <strong>Regulatory posture</strong> — U.S. registered issuer for transparency.
          </li>
        </ul>

        <h3>Potential Concerns</h3>
        <ul>
          <li>
            <strong>Regulatory risk</strong> — dividend features may be treated as
            securities.
          </li>
          <li>
            <strong>Scalability & liquidity</strong> — adoption depth affects usability.
          </li>
          <li>
            <strong>Anon vs. compliance</strong> — AML/KYC design must be carefully
            balanced.
          </li>
        </ul>

        <div class="inline-ctas">
          <a href="/signup" role="button">Create account</a>
          <a href="/playground" class="secondary">Try the UI playground</a>
        </div>
      </div>

      <!-- Illustration: yield into dividends -->
      <div class="illus">
        <svg
          viewBox="0 0 360 220"
          class="illus-svg"
          aria-label="Treasury yield to dividends"
        >
          <defs>
            <linearGradient id="grad" x1="0" x2="1">
              <stop offset="0%" stop-color="var(--pico-primary)" />
              <stop
                offset="100%"
                stop-color="color-mix(in srgb, var(--pico-primary), #fff 30%)"
              />
            </linearGradient>
          </defs>
          <rect x="10" y="20" width="140" height="70" rx="10" class="box" />
          <text x="80" y="60" text-anchor="middle" class="lbl"
            >U.S. Treasuries</text
          >

          <path d="M150 55 C 190 55, 190 110, 230 110" class="flow" />
          <rect x="230" y="90" width="120" height="40" rx="10" class="box" />
          <text x="290" y="115" text-anchor="middle" class="lbl">Yield</text>

          <path d="M290 130 C 280 160, 240 180, 200 190" class="flow" />
          <circle cx="190" cy="190" r="8" class="coin-dot" />
          <circle cx="210" cy="185" r="8" class="coin-dot" />
          <circle cx="170" cy="185" r="8" class="coin-dot" />
          <text x="180" y="210" text-anchor="middle" class="lbl small"
            >Dividends → Holders</text
          >
        </svg>
      </div>
    </div>
  </article>
</section>

<!-- Section: Fractional Investment (LockCoin) -->
<section id="lockcoin" class="container">
  <article class="card reveal">
    <header>
      <h2>2. Fractional Investment Ecosystem — LockCoin™</h2>
      <p class="muted">
        Tokenize equity, debt, or real-world assets; enable P2P trading,
        dividends, and governance.
      </p>
    </header>

    <div class="grid cols-illustration">
      <div>
        <h3>Strengths</h3>
        <ul>
          <li>
            <strong>Issue native coins</strong> for fractional ownership or financing.
          </li>
          <li>
            <strong>Direct P2P trading</strong> — minimize intermediaries.
          </li>
          <li>
            <strong>Built-in dividend distribution</strong> for transparent earnings.
          </li>
          <li><strong>Governance rights</strong> — token-based voting.</li>
        </ul>

        <h4>Use cases</h4>
        <ul>
          <li>Real-estate tokenization (fractional property shares)</li>
          <li>Equity & debt issuance for startups/SMEs</li>
          <li>Global SME financing with programmable rules</li>
        </ul>

        <h3>Potential Concerns</h3>
        <ul>
          <li><strong>Market adoption</strong> and ecosystem trust.</li>
          <li>
            <strong>Security risks</strong> — strong cryptographic and ops controls.
          </li>
          <li>
            <strong>Regulatory fragmentation</strong> across jurisdictions.
          </li>
        </ul>
      </div>

      <!-- Illustration: tokenized asset graph -->
      <div class="illus">
        <svg
          viewBox="0 0 360 220"
          class="illus-svg"
          aria-label="Tokenized asset network"
        >
          <g class="pulse">
            <circle cx="180" cy="110" r="16" class="hub" />
            <text x="180" y="114" text-anchor="middle" class="lbl small"
              >Asset</text
            >
          </g>
          <g>
            <circle cx="70" cy="60" r="12" class="node" />
            <circle cx="290" cy="60" r="12" class="node" />
            <circle cx="70" cy="170" r="12" class="node" />
            <circle cx="290" cy="170" r="12" class="node" />
            <path d="M180 110 L70 60" class="edge" />
            <path d="M180 110 L290 60" class="edge" />
            <path d="M180 110 L70 170" class="edge" />
            <path d="M180 110 L290 170" class="edge" />
          </g>
        </svg>
      </div>
    </div>
  </article>
</section>

<!-- Verdict / CTA -->
<section class="container">
  <article class="card verdict reveal">
    <h2>Overall Verdict</h2>
    <p>
      <strong>USDNote™ and LockCoin™</strong> present an ambitious financial innovation:
      combining stable-value digital money with yield distribution and decentralized
      asset tokenization.
    </p>
    <ul>
      <li>
        <strong>Strongest value</strong>: democratize access—Treasury-backed
        returns and fractional ownership.
      </li>
      <li>
        <strong>Key challenges</strong>: regulation, liquidity, and adoption at
        scale.
      </li>
    </ul>
    <div class="inline-ctas">
      <a href="/signup" role="button" class="primary">Open an account</a>
      <a href="/login" role="button" class="secondary">Log in</a>
    </div>
  </article>
</section>

<!-- Mini FAQ -->
<section class="container">
  <article class="card reveal">
    <h2>FAQs</h2>
    <details>
      <summary>How are dividends handled?</summary>
      <p>
        Interest from backing Treasuries is pooled and distributed to holders.
        Distribution flows are designed to preserve privacy while maintaining
        auditability.
      </p>
    </details>
    <details>
      <summary>Is USDNote a security?</summary>
      <p>
        Treatment may vary by jurisdiction due to dividend features. The product
        is designed with compliance in mind; always check local rules before
        participating.
      </p>
    </details>
    <details>
      <summary>What is Microchains™?</summary>
      <p>
        LockCoin’s transaction fabric emphasizing speed, privacy, and a public
        key-based audit trail rather than heavy consensus. It enables cash-like
        and check-like transfer modes.
      </p>
    </details>
  </article>
</section>

<!-- Footer CTA -->
<section class="container final-cta reveal">
  <div class="card cta">
    <h2>Ready to explore?</h2>
    <p>Start with a demo account, then upgrade when you’re ready.</p>
    <div class="cta-row">
      <a href="/playground" role="button" class="contrast">Try the Playground</a
      >
      <a href="/signup" role="button" class="primary">Get Started</a>
    </div>
  </div>
</section>

<style>
  /* Layout helpers */
  .cols-illustration {
    grid-template-columns: minmax(260px, 1fr) minmax(260px, 420px);
    align-items: center;
  }
  @media (max-width: 860px) {
    .cols-illustration {
      grid-template-columns: 1fr;
    }
  }

  /* Hero */
  .hero {
    position: relative;
    padding-top: 0.75rem;
    padding-bottom: 0.25rem;
  }
  .hero-copy h1 {
    font-size: clamp(1.6rem, 2vw + 1rem, 2.3rem);
    margin: 0 0 0.25rem;
  }
  .lead {
    color: var(--pico-muted-color);
    max-width: 70ch;
    margin: 0.25rem 0 0.75rem;
  }
  .cta {
    display: flex;
    gap: 0.6rem;
    flex-wrap: wrap;
  }
  .microcopy {
    font-size: 0.85rem;
    color: var(--pico-muted-color);
    margin-top: 0.35rem;
  }

  /* Animated hero art */
  .hero-art {
    position: absolute;
    inset: -10px 0 auto 0;
    height: 160px;
    pointer-events: none;
    opacity: 0.6;
    filter: drop-shadow(0 6px 14px rgba(0, 0, 0, 0.2));
  }
  .coin {
    position: absolute;
    width: 72px;
    height: 72px;
    animation: float 8s ease-in-out infinite;
  }
  .c1 {
    left: 6%;
    top: 10%;
    animation-duration: 7.2s;
  }
  .c2 {
    left: 22%;
    top: 28%;
    animation-duration: 8.6s;
  }
  .c3 {
    left: 38%;
    top: 8%;
    animation-duration: 7.8s;
  }
  @keyframes float {
    0%,
    100% {
      transform: translateY(0);
    }
    50% {
      transform: translateY(-12px);
    }
  }
  .coin-bg {
    fill: color-mix(in srgb, var(--pico-primary), #000 8%);
  }
  .coin-txt {
    font:
      700 28px/1 ui-sans-serif,
      system-ui,
      sans-serif;
    fill: var(--pico-primary-inverse);
  }
  .lock {
    stroke: var(--pico-primary-inverse);
    stroke-width: 3;
    fill: none;
  }
  .node {
    fill: color-mix(in srgb, var(--pico-primary), #000 12%);
  }
  .edge {
    stroke: color-mix(in srgb, var(--pico-primary), #fff 10%);
    stroke-width: 3;
    fill: none;
  }

  /* Cards + reveal-on-scroll */
  .card {
    overflow: hidden;
  }
  .reveal {
    opacity: 0;
    transform: translateY(8px);
    animation: rise 0.6s ease-out forwards;
  }
  .reveal:nth-of-type(1) {
    animation-delay: 0.05s;
  }
  .reveal:nth-of-type(2) {
    animation-delay: 0.12s;
  }
  .reveal:nth-of-type(3) {
    animation-delay: 0.18s;
  }
  @media (prefers-reduced-motion: reduce) {
    .reveal {
      opacity: 1;
      transform: none;
      animation: none;
    }
    .coin {
      animation: none;
    }
  }
  @keyframes rise {
    to {
      opacity: 1;
      transform: none;
    }
  }

  /* Illustration styling */
  .illus {
    display: grid;
    place-items: center;
    padding: 0.5rem;
  }
  .illus-svg {
    max-width: 420px;
    width: 100%;
    height: auto;
  }
  .box {
    fill: color-mix(in srgb, var(--pico-primary), #000 90%);
  }
  .lbl {
    fill: var(--pico-primary-inverse);
    font:
      600 14px/1 ui-sans-serif,
      system-ui,
      sans-serif;
  }
  .lbl.small {
    font-weight: 500;
    font-size: 12px;
  }
  .flow {
    stroke: url(#grad);
    stroke-width: 4;
    fill: none;
  }
  .coin-dot {
    fill: color-mix(in srgb, var(--pico-primary), #000 8%);
  }
  .hub {
    fill: color-mix(in srgb, var(--pico-primary), #000 12%);
  }
  .node {
    fill: color-mix(in srgb, var(--pico-primary), #000 18%);
  }
  .edge {
    stroke: color-mix(in srgb, var(--pico-primary), #fff 12%);
    stroke-width: 3;
    fill: none;
  }
  .pulse .hub {
    animation: pulse 1.6s ease-in-out infinite;
  }
  @keyframes pulse {
    0%,
    100% {
      filter: drop-shadow(0 0 0 rgba(0, 0, 0, 0));
    }
    50% {
      filter: drop-shadow(
        0 0 10px color-mix(in srgb, var(--pico-primary), #fff 25%)
      );
    }
  }

  /* Verdict & final CTA */
  .verdict ul {
    margin-top: 0.25rem;
  }
  .final-cta .cta {
    text-align: center;
  }
  .final-cta .cta-row {
    display: flex;
    gap: 0.6rem;
    justify-content: center;
    flex-wrap: wrap;
  }

  /* Buttons: optional outline helper */
  .outline {
    background: transparent;
    border: 1px solid var(--pico-muted-border-color);
  }
</style>
