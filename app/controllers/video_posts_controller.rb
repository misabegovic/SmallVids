class VideoPostsController < ApplicationController
  def show
    upvote if session[:id].present?
    @video_post = VideoPost.find(params[:id])
    @video_comment = VideoComment.new
  end

  def update
    @video_post = VideoPost.find(params[:id])
    increase_meh if params[:commit] == 'Meh'
    increase_ok if params[:commit] == "It's Ok"
    increase_like if params[:commit] == 'I like it'
    @video_post.save
    redirect_to @video_post
  end

  private

  def upvote
    @upvote = current_user.upvotes.where(video_post_id: params[:id]).first
  end
end