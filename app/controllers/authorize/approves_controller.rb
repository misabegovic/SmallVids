module Authorize
  class ApprovesController < ApplicationController
    before_action :authorize_admin

    def index
      @videos = VideoPost.all.where(is_approved: false).order(created_at: :asc).first(10)
    end

    def update
      @video_post = VideoPost.find(params[:id])
      @video_post.is_approved = true
      @video_post.save
      redirect_to @video_post
    end
  end
end