module Authorize
  class FavoritesController < ApplicationController
    before_action :authorize

    def update
      favorite = current_user.favorites
                             .find_by(favorite_user_id: params[:id])

      #conditionals
      create_favorite(params[:id]) if favorite.nil?
      favorite.delete if favorite.present?

      redirect_to profile_path(User.find(params[:id]))
    end

    def show
      @user = User.find(params[:id])

      #conditionals
      get_favorites if params[:following]
      get_followers if params[:followers]
    end

    private

    def create_favorite(favorite_user)
      Favorite.create(
        user: current_user,
        favorite_user_id: favorite_user
      )
    end

    def get_favorites
      if @user.favorites.length > 0
        counter = 1
        @user.favorites.find_each do |f|
          user = User.where(id: f.favorite_user_id)
          if counter = 1
            @favorites = user
            counter+= 1
          else
            @favorites.merge(user)
          end
        end
      else
        @favorites = User.none
      end
    end

    def get_followers
      followers = Favorite.all.where(favorite_user_id: @user.id)
      if followers.length > 0
        counter = 1
        followers.find_each do |f|
          user = User.where(id: f.user)
          if counter = 1
            @followed = user
            counter+= 1
          else
            @followed.merge(user)
          end
        end
      else
        @followed = User.none
      end
    end
  end
end