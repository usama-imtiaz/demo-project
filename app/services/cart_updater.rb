class CartUpdater < ApplicationService

  def add product, user
    user.cart.bucket[product.id.to_s] = user.cart.bucket[product.id.to_s].present? ? user.cart.bucket[product.id.to_s]+1 : 1
    user.cart.gross_total += Product.find_by(id: product.id).unit_price
    user.cart.net_total = user.cart.coupon_applied ? user.cart.gross_total - (user.cart.gross_total * user.cart.discount) : user.cart.gross_total
    user.cart.save ? true : false
  end

  def remove product, user
    if user.cart.bucket[product.id.to_s].present?
      user.cart.bucket[product.id.to_s] -= 1
      user.cart.bucket.delete product.id.to_s if user.cart.bucket[product.id.to_s] < 1

      if user.cart.bucket.empty?
        user.cart.destroy
      else
        user.cart.gross_total -= Product.find_by(id: product.id).unit_price
        user.cart.net_total = user.cart.coupon_applied ? user.cart.gross_total - (user.cart.gross_total * user.cart.discount) : user.cart.gross_total
      end
      user.cart.save ? true : false
    end
  end

  def move_session_cart_to_user user, session
    return if !session[:cart].present?
    user.build_cart(bucket: {}, gross_total: 0, net_total: 0) if user.cart.nil?
    @hold_items = session[:cart].keys.select { |key| !user.products.pluck(:id).include?(key.to_i) }
    return if @hold_items.empty?

    @hold_items.each do |item|
      if user.cart.bucket[item].present?
        user.cart.bucket[item] += session[:cart][item]
        user.cart.gross_total += (Product.find(item.to_i).unit_price * session[:cart][item])
      else
        user.cart.bucket[item] = session[:cart][item]
        user.cart.gross_total += (Product.find(item.to_i).unit_price * session[:cart][item])
      end
    end
    user.cart.net_total = user.cart.gross_total
    if user.cart.save
      session.delete :cart
      true
    end
  end
end
