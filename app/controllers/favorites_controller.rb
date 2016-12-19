class FavoritesController < ApplicationController

  def create
    if logged_in?
      @product =  Product.find_or_create_by(product_params)
      @favorite = Favorite.new(product_id: @product.id)
      @favorite.user_id = current_user.id
      @favorite.save
      if request.xhr?
        "thing"
      end
    end
  end

  def destroy
     favorite = Favorite.find(params[:id])
     @product = favorite.product
     if logged_in? && authorized?(favorite)
       favorite.destroy
    else
      redirect_to new_session_path
     end
     redirect_to user_path(current_user)
  end

private

  def product_params
    params.require(:p).permit(:image, :link, :name, :price)
  end
end
