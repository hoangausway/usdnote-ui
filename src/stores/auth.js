// stores/auth.js
import { writable } from "svelte/store";

export const isAuthed = writable(false);

export function login() {
  isAuthed.set(true);
}

export function logout() {
  isAuthed.set(false);
}
