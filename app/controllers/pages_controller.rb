class PagesController < ApplicationController
  def index
    redirect_to tag_path(random) if (ActsAsTaggableOn::Tag.all.length > 0 && params[:random])
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

  def random
    random_num = Random.rand(ActsAsTaggableOn::Tag.all.length)
    ActsAsTaggableOn::Tag.all.each do |tag|
      if random_num < 1
        return tag.name
      end
      random_num = random_num/2
    end
  end
end