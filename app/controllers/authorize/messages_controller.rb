module Authorize
  class MessagesController < ApplicationController
    before_action :authorize

    def index
      @messages = current_user.categories.first.messages
      @category_id = current_user.categories.first.id
      change_messages if params[:category_id]
      change_messages_now if params[:message] && params[:message][:category_id]
      condition_search = params[:search] && params[:search][:tags] != ''
      @messages = search(params[:search][:tags], @messages) if condition_search
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
      redirect_to messages_path if @message.save
      increase_count(@message.tag_list) if @message.save
    end

    def destroy
      @message = Message.find(params[:id])
      destroy_tags(@message.tag_list)
      @message.folders.find_by(user: current_user).delete
      redirect_to messages_path
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

    def change_messages
      @messages = current_user.categories.find(params[:category_id]).messages
      @category_id = params[:category_id]
    end

    def change_messages_now
      @messages = current_user.categories.find(params[:message][:category_id]).messages
    end

    def destroy_tags(tags)
      tags.each do |tag|
        tag = ActsAsTaggableOn::Tag.find_by(name: tag)
        decrease_count(tag) if tag.taggings_count > 1
        tag.delete if tag.taggings_count = 1
      end
    end

    def decrease_count(tag)
      tag.update(taggings_count: tag.taggings_count - 1)
    end

    def increase_count(tags)
      tags.each do |t|
        tag = ActsAsTaggableOn::Tag.find_by(name: t)
        tag.update(taggings_count: tag.taggings_count + 1)
      end
    end
  end
end