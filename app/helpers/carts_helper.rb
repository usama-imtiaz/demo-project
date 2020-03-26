module CartsHelper
  def add_to_session_cart(session, index)
    session[:cart] ||= {}
    session[:cart][index] = session[:cart][index].present? ? session[:cart][index]+1 : 1
    @value = session[:cart][index]
  end

  def remove_from_session_cart(session, index)
    if session[:cart][index].present?
      session[:cart][index] -= 1
      @value = session[:cart][index] > 0 ? session[:cart][index] : (session[:cart].delete index)
    end
  end

  def getTempCart(session)
    @cart_items = session[:cart]
    @cart_prods = Product.where(id: @cart_items.keys) if @cart_items
  end

  def getTempGrossTotal(session)
    getTempCart(session)
    @cart_prods.map{ |prod| prod.unit_price * session[:cart][prod.id.to_s] }.reduce(0) { |sum, n| sum + n }
  end

  def setTempCartTotal
    @gross_total = getTempGrossTotal(session)
    @net_total = @gross_total
  end

  def gross_net_value_zero
    @gross_total = 0
    @net_total = 0
    @value = 0
  end
end
