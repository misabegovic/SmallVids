module Authorize
  class CommunitiesController < ApplicationController
    before_action :authorize

    def index
      @video_posts = VideoPost.all.where(is_approved: true)
      favorites if params[:favorites]
      condition_search = params[:search] && params[:search][:tags] != ''
      @video_posts = search(params[:search][:tags], @video_posts) if condition_search
      @video_posts = @video_posts.order(created_at: :desc).first(20)
    end

    def show
      @video_posts = VideoPost.all.where(is_approved: false)
      favorites_unapproved if params[:favorites]
      condition_search = params[:search] && params[:search][:tags] != ''
      @video_posts = search(params[:search][:tags], @video_posts) if condition_search
      @video_posts = @video_posts.order(created_at: :desc).first(20)
    end

    private

    def favorites
      if current_user.favorites.length > 0
        counter = 1
        current_user.favorites.find_each do |f|
          user = User.find(f.favorite_user_id)
          if counter = 1
            @video_posts = user.video_posts.where(is_approved: true)
            counter+= 1
          else
            @video_posts.merge(user.video_posts.where(is_approved: true))
          end
        end
      else
        @video_posts = VideoPost.none
      end
    end

    def favorites_unapproved
      if current_user.favorites.length > 0
        counter = 1
        current_user.favorites.find_each do |f|
          user = User.find(f.favorite_user_id)
          if counter = 1
            @video_posts = user.video_posts.where(is_approved: false)
            counter+= 1
          else
            @video_posts.merge(user.video_posts.where(is_approved: false))
          end
        end
      else
        @video_posts = VideoPost.none
      end
    end
  end
end