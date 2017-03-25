class TagsController < ApplicationController
  def show
    @most_used_tags = ActsAsTaggableOn::Tag.most_used(10)
    @video_posts = VideoPost.tagged_with(params[:id]).where(is_approved: true).first(20)
  end
end