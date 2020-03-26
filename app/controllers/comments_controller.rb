class CommentsController < ApplicationController
  before_action :set_product
  before_action :set_comment, only: [:edit, :update]
  before_action :authenticate_user!

  def create
    @comment = @product.comments.create(comment_params.merge(user_id: current_user.id))
  end

  def edit
    @comments = @product.comments.order("created_at DESC")
  end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment = @product.comments.find(params[:id])
    @comment.destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:comment, :product_id)
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_comment
      @comment = @product.comments.find(params[:id])
    end
end
