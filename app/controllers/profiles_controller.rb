class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @coupons = current_user.coupons.present? ? current_user.coupons : {}
    @products = current_user.products
  end
end
