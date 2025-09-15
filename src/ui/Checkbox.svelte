<script>
  export let id;
  export let checked = false;
  export let label = "";
</script>

<label class="label-inline">
  <input {id} type="checkbox" bind:checked />
  <span><slot>{label}</slot></span>
</label>
