module Authorize
  class ProfilesController < ApplicationController
    before_action :authorize

    def show
      @favorite = current_user.favorites.where(favorite_user_id: params[:id]).first
      @user = User.find(params[:id])
      @followers = Favorite.all.where(favorite_user_id: @user.id)
      @video_posts = @user.video_posts
      user_approved if params[:user] && params[:user][:approved]
      user_not_approved if params[:user] && params[:user][:not_approved]
      condition_search = params[:search] && params[:search][:tags] != ''
      @video_posts = search(params[:search][:tags], @video_posts) if condition_search
      @video_posts = @video_posts.order(created_at: :desc).first(10)
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to profile_path(@user)
    end

    def destroy
      @user = User.find(params[:id])
      @user.delete
      session[:user_id] = nil
      redirect_to new_session_path
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

    def user_approved
      @video_posts = @user.video_posts.where(is_approved: true)
    end

    def user_not_approved
      @video_posts = @user.video_posts.where(is_approved: false)
    end
  end
end