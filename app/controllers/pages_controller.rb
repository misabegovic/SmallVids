class PagesController < ApplicationController
  def index
    redirect_to tag_path(random) if (ActsAsTaggableOn::Tag.all.length > 0 && params[:random])
    
    @most_used_tags = ActsAsTaggableOn::Tag.most_used(10)
    @videos = VideoPost.all

    search_conditions = params[:search] && params[:search][:tags]
    @videos = search(params[:search][:tags], @videos) if search_conditions
    
    @videos = @videos.where(is_approved: true)
                     .order(created_at: :desc)
                     .first(20)
  end

  private

  def random
    return ActsAsTaggableOn::Tag.order('RANDOM()')
                                .first
                                .name
    #return ActsAsTaggableOn::Tag.where('RANDOM() >= 0.2').first.name
  end
end