class PagesController < ApplicationController
  def index
    @most_used_tags = ActsAsTaggableOn::Tag.most_used(10)
    @videos = VideoPost.all
    search(params[:search][:tags]) if params[:search] && params[:search][:tags] != ''
    @videos = @videos.where(is_approved: true).order(created_at: :desc).first(20)
  end

  private

  def search(tags)
    tags.split(',').map do |name|
      @videos = @videos.tagged_with(name)
    end
  end
end