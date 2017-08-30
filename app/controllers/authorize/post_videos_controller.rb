module Authorize
  class PostVideosController < ApplicationController
    before_action :authorize

    def index
      @video = VideoPost.new
    end

    def create
      @video = VideoPost.new(video_params)
      @video.user = current_user

      #conditionals
      resize_tags if @video.tag_list
      @video.is_approved = true if current_user.is_admin
      redirect_to @video if @video.save
      render :index unless @video.save
    end

    def edit
      @video = VideoPost.find(params[:id])
    end

    def update
      @video = VideoPost.find(params[:id])
      @video.update(video_params)

      redirect_to @video
    end

    def destroy
      video = VideoPost.find(params[:id])

      video.uploaded_video.remove!
      destroy_tags(video.tag_list)
      video.destroy

      redirect_to approves_path
    end

    private

    def video_params
      params.require(:video_post)
            .permit(
              :uploaded_video,
              :tag_list
            )
    end

    def destroy_tags(tags)
      tags.each do |tag|
        tag = ActsAsTaggableOn::Tag.find_by(name: tag)
        decrease_count(tag) if tag.taggings_count > 1
        tag.delete if tag.taggings_count = 1
      end
    end

    def decrease_count(tag)
      tag.taggings_count = tag.taggings_count - 1
    end

    def resize_tags
      @video.tag_list = @video.tag_list.first(5)
      i = 0
      @video.tag_list.each do |tag|
        @video.tag_list[i] = tag[0..15]
        i += 1
      end
    end
  end
end