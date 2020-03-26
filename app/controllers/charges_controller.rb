class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:create]

  DEFAULT_CURRENCY = 'usd'.freeze

  def new
  end

  def create
    return redirect_to carts_path, alert: "Not Permitted :)" if @cart.nil? || @cart.bucket.empty?

    @cartItems = @cart.bucket
    @cartProds = Product.where(id: @cartItems.keys.map{ |key| key.to_i }) if @cartItems
    @line_items = []
    @cartProds.each do |prod|
      prod_object = {
        name: prod.name,
        description: prod.description,
        amount: ((prod.unit_price - (prod.unit_price * @cart.discount)) * 100).to_i,
        quantity: @cart.bucket[prod.id.to_s],
        currency: DEFAULT_CURRENCY
      }
      @line_items.push(prod_object)
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: @line_items,
      success_url: charges_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: carts_url
    )
  end

  def success
    return redirect_to root_path if !params[:session_id].present?

    @prods = Product.where(id: current_user.cart.bucket.keys.map{ |key| key.to_i})
    @prods.each do |prod|
      prod.in_stock -= current_user.cart.bucket[prod.id.to_s]
      prod.save
    end

    @coup = Coupon.find(session[:coupon_id])
    @coup.quantity -= 1
    @coup.save
    current_user.cart.delete

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel
  end

  private
    def set_cart
      @cart = Cart.find(params[:cart])
    end
end