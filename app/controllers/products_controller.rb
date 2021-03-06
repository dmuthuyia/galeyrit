class ProductsController < ApplicationController
before_action :find_product, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
before_action :authenticate_user!, except: [:index, :show]

def index
	
		@products = Product.all.order("created_at DESC")
end

def show
	#@comments = Comment.where(product_id: @product)
	#@random_product = product.where.not(id: @product).order("RANDOM()").first
end

def new
	@product = current_user.products.build
end

def create
	@product = current_user.products.build(product_params)

	if @product.save
		redirect_to @product
	else
		render 'new'
	end
end

def edit
end

def update
	if @product.update(product_params)
		redirect_to @product
	else
		render 'edit'
	end
end

def destroy
	@product.destroy
	redirect_to root_path
end

def upvote
	@product.upvote_by current_user
	redirect_to :back
end

def downvote
	@product.downvote_by current_user
	redirect_to :back
end

private

def find_product
	@product = Product.find(params[:id])
end

def product_params
	params.require(:product).permit(:title, :description, :url, :product_img)
end
end
