module Authorize
  class FavoritesController < ApplicationController
    before_action :authorize

    def update
      favorite = current_user.favorites.where(favorite_user_id: params[:id]).first
      create_favorite(params[:id]) if favorite.nil?
      favorite.delete if favorite.present?
      redirect_to profile_path(User.find(params[:id]))
    end

    private

    def create_favorite(favorite_user)
      Favorite.create(user: current_user, favorite_user_id: favorite_user)
    end
  end
end