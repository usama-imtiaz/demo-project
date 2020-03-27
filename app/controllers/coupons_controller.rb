class CouponsController < ApplicationController
  before_action :set_coupon, :set_user, only: [:apply_coupon]

  def index
    @coupon = Coupon.new
    @coupons = current_user.coupons.present? ? current_user.coupons : {}
  end

  def create
    @coupon = current_user.coupons.build(coupon_params)
    @coupon.save ? (flash[:notice]="Coupon created") : (flash[:alert]="Something went wrong")
    redirect_to coupons_path
  end

  def apply_coupon
    if @coupon.applying_coupon(@user)
      session[:coupon_id] = @coupon.id
      redirect_to cart_index_path, notice: 'Coupon applied'
    else
      redirect_to cart_index_path, alert: 'Coupon already applied'
    end
  end

  def get_coupons
    @coupon = Coupon.pluck(:name)
  end

  private
  def coupon_params
    params.require(:coupon).permit(:name, :percentage, :quantity)
  end

  def set_user
    @user = User.find_by(id: current_user.id)
  end


  def set_coupon
    @coupon = Coupon.where(name: params[:promo]).first
    return redirect_to cart_index_path, alert: "Cannot apply own coupon..." if @coupon.user_id == current_user.id
    redirect_to cart_index_path notice: "Coupon no longer available" if @coupon.quantity < 1
  end
end
