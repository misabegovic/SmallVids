module Authorize
  class CommunitiesController < ApplicationController
    before_action :authorize

    def index
      @video_posts = VideoPost.all.where(is_approved: true)
      favorites if params[:favorites]
      search(params[:search][:tags]) if params[:search] && params[:search][:tags] != ''
      @video_posts = @video_posts.order(created_at: :desc).first(20)
    end

    def show
      @video_posts = VideoPost.all.where(is_approved: false)
      search(params[:search][:tags]) if params[:search] && params[:search][:tags] != ''
      @video_posts = @video_posts.order(created_at: :desc).first(20)
    end

    private

    def search(tags)
      tags.split(',').map do |name|
        @video_posts = @video_posts.tagged_with(name)
      end
    end

    def favorites
      counter = 1
      current_user.favorites.each do |f|
        user = User.find(f.favorite_user_id)
        if counter = 1
          @video_posts = user.video_posts.where(is_approved: true)
          counter+= counter
        else
          @video_posts = @video_posts.or(user.video_posts.where(is_approved: true))
        end
      end
    end
  end
end