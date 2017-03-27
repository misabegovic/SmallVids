class VideoPostsController < ApplicationController
  def show
    upvote if session[:id].present?
    @video_post = VideoPost.find(params[:id])
    @video_comment = VideoComment.new
  end

  def update
    @video_post = VideoPost.find(params[:id])
    @video_post.save
    redirect_to @video_post
  end

  private

  def upvote
    @upvote = current_user.upvotes.find_by(video_post_id: params[:id])
  end
end