$(document).on('click', '.add_to_cart', function() {
  let prod_id = this.previousElementSibling.dataset.prodId
  let user_id = this.previousElementSibling.dataset.userId
  
  $.ajax({
    type: "PUT", 
    url: "/add_to_cart",
    data: {"prod_id": prod_id, "user_id": user_id },
    success: function(data, textStatus, jqXHR){},
    error: function(jqXHR, textStatus, errorThrown){} 
  });
  
  setTimeout(function() {
    $('.alert').fadeOut('slow');
  }, 4000);
});

$(document).on('click', '.remove_from_cart', function() {
  let prod_id = this.previousElementSibling.previousElementSibling.dataset.prodId
  let user_id = this.previousElementSibling.previousElementSibling.dataset.userId

  $.ajax({
    type: "PUT", 
    url: "/remove_from_cart",
    data: {"prod_id": prod_id, "user_id": user_id },
    success: function(data, textStatus, jqXHR){},
    error: function(jqXHR, textStatus, errorThrown){} 
  });
  
  setTimeout(function() {
    $('.alert').fadeOut('slow');
  }, 4000);
});

$(document).on('click','#checkout', function () {
  $("#spinner").removeClass('remove_display')
});

$(document).on('ready turbolinks:load' ,function blink() { 
  $('.blink_me').fadeOut(700).fadeIn(700, blink); 
  
});

$(document).on('click turbolinks:load', '#coupons' ,function() {
  $.ajax({
    type: "GET", 
    source: "/coupons/get_coupons"
  });
});

$(document).on('click turbolinks:load', '.coup' ,function() {
  var coupon = $(this).html()
  $.ajax({
    type: "POST", 
    url: "/coupons/apply_coupon",
    data: {"promo":coupon}
  });
});