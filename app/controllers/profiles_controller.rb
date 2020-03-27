class ProfilesController < ApplicationController

  def index
    @coupons = current_user.coupons.present? ? current_user.coupons : {}
    @products = current_user.products
  end
end
