$(document).on("keyup", "#text-check", function() {
  maxLength = 200;
  if (this.value.length >= maxLength) {
    this.value = this.value.slice(0, maxLength);
  }
});
