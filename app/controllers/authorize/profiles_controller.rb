module Authorize
  class ProfilesController < ApplicationController
    before_action :authorize

    def show
      @user = User.find(params[:id])
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