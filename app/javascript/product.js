$(document).on("keyup", "#text-check", function() {
  maxLength = 200;
  if (this.value.length >= maxLength) {
    this.value = this.value.slice(0, maxLength);
  }
});

$(document).on('ready turbolinks:load', function () {
  $("#term").autocomplete({
    source: "/products/autocomplete",
    minLength: 1,
    select: function (event, ui){
      $("#term").val(ui.item.value);
      window.location.replace("/products/" + ui.item.id);
      // $(this).closest('form').submit();
    }
  });
});
