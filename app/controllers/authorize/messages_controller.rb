module Authorize
  class MessagesController < ApplicationController
    before_action :authorize

    def index
      @messages = current_user.categories.first.messages
      change_messages if params[:category_id]
    end

    def show
      @message = Message.find(params[:id])
    end

    def new  
    end

    def create
      @message = Message.new(message_params)
      @message.from_id = current_user.id
      user_to(params[:message][:to_id]) if params[:message][:parent_id].nil?
      redirect_to messages_path
    end

    def destroy
      @message = Message.find(params[:id])
      @message.folders.find_by(user: current_user).delete
      redirect_to messages_path
    end

    private

    def message_params
      params.require(:message)
            .permit(
              :subject,
              :content,
              :to_id,
              :parent_id
            )
    end

    def user_to(usernames)
      usernames.split(',').map do |username|
        user = User.find_by(username: username)
        save_message(user.id) if user.nil? == false
      end
    end

    def save_message(user_id)
      @message.to_id = user_id
      temp = @message
      temp.save
    end

    def change_messages
      @messages = current_user.categories.find(params[:category_id]).messages
    end
  end
end