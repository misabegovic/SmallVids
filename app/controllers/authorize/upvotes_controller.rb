module Authorize
  class UpvotesController < ApplicationController
    before_action :authorize

    def update
      upvote = current_user.upvotes.where(video_post_id: params[:id]).first

      #conditionals
      create_upvote(params[:id]) if upvote.nil?
      upvote.delete if upvote.present?
      
      redirect_to VideoPost.find(params[:id])
    end

    def show
      @video_post = VideoPost.find(params[:id])
      @upvotes = Upvote.where(video_post_id: @video_post.id)
    end

    private

    def create_upvote(video_id)
      Upvote.create(user: current_user,video_post_id: video_id)
    end
  end
end