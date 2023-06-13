class Public::RelationshipsController < ApplicationController

  # フォローするとき
  def create
    current_customer.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    current_customer.unfollow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    customer = Customer.find(params[:user_id])
    @customers = customer.followings
  end
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:user_id])
    @customers = customer.followers
  end

end
