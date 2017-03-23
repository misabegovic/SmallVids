class VideoPostsController < ApplicationController
  def show
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

  def increase_meh
    @video_post.is_meh = @video_post.is_meh + 1
  end

  def increase_ok
    @video_post.is_ok = @video_post.is_ok + 1   
  end

  def increase_like
    @video_post.i_like_it = @video_post.i_like_it + 1
  end
end