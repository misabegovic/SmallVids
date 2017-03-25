module Authorize
  class CommunitiesController < ApplicationController
    before_action :authorize

    def index
      @most_used_tags = ActsAsTaggableOn::Tag.most_used(10)
      @video_posts = VideoPost.all.where(is_approved: true).order(created_at: :desc).first(20)
      not_approved if params[:not_approved]
    end

    private

    def not_approved
      @video_posts = VideoPost.all.where(is_approved: false).order(created_at: :desc).first(20)
    end
  end
end