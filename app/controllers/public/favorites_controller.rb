class Public::FavoritesController < ApplicationController

  def create
    illustration = Illustration.find(params[:illustration_id])
    favorite = current_customer.favorites.new(illustration_id: illustration.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    illustration = Illustration.find(params[:illustration_id])
    favorite = current_customer.favorites.find_by(illustration_id: illustration.id)
    favorite.destroy
    redirect_to request.referer

  end

end
