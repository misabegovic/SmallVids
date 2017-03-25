module Authorize
  class CommunitiesController < ApplicationController
    before_action :authorize

    def index
      @video_posts = VideoPost.all.where(is_approved: true)
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
  end
end