<script>
  export let name = "arrow";
  const paths = {
    home: "M3 11l9-8 9 8v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z M9 22V12h6v10",
    wallet:
      "M3 7h16a2 2 0 0 1 2 2v1H15a2 2 0 0 0 0 4h6v1a2 2 0 0 1-2 2H3z M15 12h8",
    trade: "M7 17V7M7 7L4 10M7 7l3 3M17 7v10m0 0 3-3m-3 3-3-3",
    swap: "M4 7h11l-3-3M20 17H9l3 3",
    bundle: "M6 6h12v12H6z M9 9h6v6H9z",
    nft: "M12 2l7 4v8l-7 4-7-4V6z M9 8h6v8H9z",
    otc: "M4 7h16M4 12h16M4 17h16",
    market: "M4 17l4-5 3 3 5-7 4 5",
    account: "M12 7a3 3 0 1 1 0 6 3 3 0 0 1 0-6zm-6 12a6 6 0 1 1 12 0z",
    settings: "M12 8a4 4 0 1 1 0 8 4 4 0 0 1 0-8",
    help: "M12 18h.01M9 9a3 3 0 1 1 6 1c0 2-3 2-3 5",
    logout: "M10 17l-5-5 5-5M5 12h12M17 7v10",
    plus: "M12 5v14M5 12h14",
    arrow: "M5 12h14M13 5l7 7-7 7",
  };
</script>

<svg
  width="22"
  height="22"
  viewBox="0 0 24 24"
  fill="none"
  stroke="currentColor"
  stroke-width="2"
  stroke-linecap="round"
  stroke-linejoin="round"
  aria-hidden="true"
>
  <path d={paths[name] || paths.arrow} />
</svg>
