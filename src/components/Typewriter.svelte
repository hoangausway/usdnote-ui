<script>
  import { createEventDispatcher } from "svelte";

  // Props
  export let text = "";
  export let speed = 16; // ms per character
  export let threshold = 0.2; // % of element visible before starting

  // Internals
  let span; // span element to display typed text
  let caretActive = false;
  let observer;
  let timer;
  let index = 0;

  const dispatch = createEventDispatcher();

  function startTyping() {
    stopTyping(); // reset any previous run
    index = 0;
    span.textContent = "";
    caretActive = true;
    dispatch("start");

    timer = setInterval(() => {
      span.textContent = text.slice(0, ++index);
      if (index >= text.length) {
        stopTyping(true);
        dispatch("done");
      }
    }, speed);
  }

  function stopTyping(finished = false) {
    clearInterval(timer);
    caretActive = !finished; // blink while typing; hide after done
    if (!finished) span.textContent = "";
  }

  function setupObserver(node) {
    observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) startTyping();
        else stopTyping(false);
      },
      { threshold }
    );

    observer.observe(node);

    return {
      destroy() {
        observer.disconnect();
        stopTyping();
      },
    };
  }
</script>

<h2 use:setupObserver>
  <span bind:this={span}></span>
  <span class="caret" class:active={caretActive} aria-hidden="true"></span>
</h2>

<style>
  h2 {
    position: relative;
    line-height: 1.3;
    color: var(--brand-jade-800);
    font-weight: 500;
  }

  .caret {
    display: inline-block;
    width: 2px;
    height: 1em;
    background: var(--brand-amber-600, #f59e0b);
    margin-left: 2px;
    vertical-align: -0.1em;
    opacity: 0;
  }

  .caret.active {
    animation: blink 1s step-end infinite;
    opacity: 1;
  }

  @keyframes blink {
    50% {
      opacity: 0;
    }
  }
</style>
