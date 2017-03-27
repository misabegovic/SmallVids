module Authorize
  class MessagesController < ApplicationController
    before_action :authorize

    def index
      if params[:category_id].present?
        @messages = current_user.categories.find(params[:category_id]).messages
      else
        @messages = current_user.categories.first.messages
      end   
    end

    def show
      @message = Message.find(params[:id])
      @reply = Message.new
    end

    def new
      @message = Message.new
    end

    def create
      @message = Message.new(message_params)
      @message.from_id = current_user.id
      user_to(params[:message][:to_id]) if params[:message][:parent_id] == ''
      redirect_to mailboxes_path if @message.save
    end

    def destroy
      @message = Message.find(params[:id])
      if @message.folders.find_by(user: current_user).category.name == "Trash" 
        @message.folders.find_by(user: current_user).delete
      else
        @message.folders.find_by(user: current_user)
                .update(category: current_user.categories.find_by(name: "Trash"))
      end
      redirect_to mailboxes_path
    end

    def move_to
      Folder.where(user: current_user)
            .where(message_id: params[:message_ids])
            .update_all(category_id: params[:categories][:ids])
    end

    private

    def message_params
      params.require(:message)
            .permit(
              :subject,
              :tag_list,
              :content,
              :to_id,
              :parent_id
            )
    end

    def user_to(username)
      @message.to_id = User.find_by(username: params[:message][:to_id]).id
    end
  end
end