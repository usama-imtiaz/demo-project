class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :autocomplete, :add_to_cart]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]

  def index
    @products = Product.search(params[:term])
  end

  def show
    @comment = Comment.new
    @comments = @product.comments.order("created_at DESC")
  end

  def new
    @product = Product.new
  end

  def edit 
  end

  def create
    @product = Product.new(product_params)
    @product.save ? (redirect_to @product, notice: 'Product was successfully created.') : (render 'new', alert: "Something went wrong")
  end

  def update
    @product.update(product_params) ? (redirect_to @product, notice: 'Product was successfully updated.') : (render :edit)
  end

  def destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.' if @product.destroy
  end

  def autocomplete
    @products = Product.search(params[:term])
    render json: @products.map{ |product| {id: product.id, value: product.name }}
  end

  private
    def set_product
      @product = Product.find_by(id: params[:id])
    end

    def check_owner
      if current_user.id != @product.user_id
        flash[:alert] = "You are not permitted!"
        redirect_to products_path(session[:user_id])
        false
      end
    end

    def product_params
      params.require(:product).permit(:name, :category, :unit_price, :stock, :description, :user_id, images: [])
    end
end
