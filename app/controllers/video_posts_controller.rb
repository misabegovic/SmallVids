class VideoPostsController < ApplicationController
  def show
    @video_post = VideoPost.find(params[:id])
    @video_comment = VideoComment.new

    upvote if session[:id].present?
  end

  def update
    @video_post = VideoPost.find(params[:id])
    @video_post.save
    redirect_to @video_post
  end

  private

  def upvote
    @upvote = current_user.upvotes
                          .find_by(video_post_id: params[:id])
  end
end