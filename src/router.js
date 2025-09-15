import page from "page";
import Home from "./pages/Home.svelte";
import Playground from "./pages/Playground.svelte";
import Signup from "./pages/Signup.svelte";
import Login from "./pages/Login.svelte";
import Dashboard from "./pages/Dashboard.svelte";

const mount = (Comp) => {
  const target = document.getElementById("view");
  if (!target) return;
  target.innerHTML = "";
  new Comp({ target });
};

page("/", () => mount(Home));
page("/dashboard", () => mount(Dashboard));
page("/playground", () => mount(Playground));
page("/signup", () => mount(Signup));
page("/login", () => mount(Login));
page(); // start router
