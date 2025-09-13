import page from "page";
import Home from "./pages/Home.svelte";
import Playground from "./pages/Playground.svelte";

const mount = (Comp) => {
  const target = document.getElementById("view");
  if (!target) return;
  target.innerHTML = "";
  new Comp({ target });
};

page("/", () => mount(Home));
page("/playground", () => mount(Playground));
page(); // start router
