class CartsController < ApplicationController
  include CartsHelper

  before_action :set_product, only: %i[add_to_cart remove_from_cart]
  before_action :set_user_or_temp_cart

  def index
    if user_signed_in?
      @cart_items = @user.cart.present? ? @user.cart.bucket : {}
      @cart_prods = Product.where(id: @cart_items.keys.map{ |key| key.to_i }) if @cart_items
    elsif session[:cart].present?
      @gross_total = getTempGrossTotal(session)
    else
      @cart_prods = {}
      gross_net_value_zero
    end
  end

  def add_to_cart
    return redirect_to products_path, alert: "Cannot buy own product !" if @user == @product.user
    return redirect_to carts_path, alert: "Product out of stock!" if @product.in_stock < 1

    if user_signed_in?
      if @user.cart.present? ? CartUpdater.new.add(@product, @user) : create
        set_gross_net_total
        @value = @user.cart.bucket[@product.id.to_s]
      else
        redirect_to carts_path, alert: 'Something went wrong x_x'
      end
    else
      add_to_session_cart(session, params[:prod_id])
      getTempCart(session)
      setTempCartTotal
    end
  end

  def remove_from_cart
    if user_signed_in?
      if CartUpdater.new.remove(@product, @user)
        set_gross_net_total
        @value = @user.cart.bucket[@product.id.to_s].present? ? @user.cart.bucket[@product.id.to_s] : 0
      elsif @user.cart.present?
        redirect_to carts_path
      else
        gross_net_value_zero
        redirect_to carts_path
      end
    else
      remove_from_session_cart(session, params[:prod_id])
      getTempCart(session)
      setTempCartTotal
    end
  end

  private
    def create
      @bucket = {}
      @bucket[@product.id.to_s] = 1
      @cart = Cart.new(user: @user, gross_total: @product.unit_price, net_total: @product.unit_price, discount: 0, bucket: @bucket, coupon_applied: false )
      @cart.save
    end

    def set_user_or_temp_cart
      user_signed_in? ? set_user : getTempCart(session)
      CartUpdater.new.move_session_cart_to_user(@user, session) if user_signed_in? && session[:cart].present?
    end

    def set_user 
      @user = User.find_by(id: current_user.id)
    end

    def set_product
      @product = Product.find_by(id: params[:prod_id]) if params[:prod_id]
    end

    def set_gross_net_total
      @gross_total = @user.cart.gross_total
      @net_total = @user.cart.net_total
    end
end
