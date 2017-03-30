class VideoCommentsController < ApplicationController
	def create
    comment = VideoComment.new(video_comment_params)
    comment.user = current_user
    video = comment.video_post
    comment.save
    redirect_to video
	end
  
	def destroy
		comment = VideoComment.find(params[:id])
    video = comment.video_post
    comment.destroy
    redirect_to video
	end

  private

  def video_comment_params
    params.require(:video_comment)
          .permit(
            :content,
            :video_post_id
          )
  end
end