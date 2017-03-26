module Authorize
  class ProfilesController < ApplicationController
    before_action :authorize

    def show
      @favorite = current_user.favorites.where(favorite_user_id: params[:id]).first
      @user = User.find(params[:id])
      @followers = Favorite.all.where(favorite_user_id: @user.id)
      @approved_posts = @user.video_posts.where(is_approved: true)
      @not_approved_num = @user.video_posts.where(is_approved: false).length
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to profile_path(@user)
    end

    private

    def user_params
      params.require(:user)
      .permit(
        :username,
        :password,
        :password_confirmation,
        :profile_photo
      )
    end
  end
end