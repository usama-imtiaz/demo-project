$(document).on('ready turbolinks:load', function () {
  $("#myprod").autocomplete({
    source: "/profiles/autocomplete",
    minLength: 1,
    select: function (event, ui){
      $("#myprod").val(ui.item.value);
      window.location.replace("/products/" + ui.item.id);
      // $(this).closest('form').submit();
    }
  });
});

