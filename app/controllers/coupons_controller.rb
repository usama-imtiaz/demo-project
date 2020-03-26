class CouponsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coupon, only: [:apply_coupon]

  def index
    @coup = current_user.coupons.build
    @coupons = current_user.coupons.present? ? current_user.coupons : {}
  end

  def create
    @coupon = Coupon.new(coupon_params)
    @coupon.save ? (flash[:notice]="Coupon created") : (flash[:alert]="Something went wrong")
    redirect_to coupons_path
  end

  def apply_coupon
    if @coupon.apply_coupon(current_user)
      session[:coupon_id] = @coupon.id
      redirect_to carts_path, notice: "Coupon applied"
    else
      redirect_to carts_path, alert: "Coupon already applied"
    end
  end

  def get_coupons
    @coupon = Coupon.pluck(:name)
  end

  private
  def coupon_params
    params.require(:coupon).permit(:user_id, :name, :percentage, :quantity)
  end

  def set_coupon
    @coupon = Coupon.where(name: params[:promo]).first
    return redirect_to carts_path, alert: "Cannot apply own coupon..." if @coupon.user_id == current_user.id
    redirect_to carts_path notice: "Coupon no longer available" if @coupon.quantity < 1
  end
end
