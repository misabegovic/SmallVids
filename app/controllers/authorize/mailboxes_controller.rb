module Authorize
  class MailboxesController < ApplicationController
    before_action :authorize

    def index
      @categories = current_user.categories
      if params[:name]
        @messages = current_user.categories.find_by(params[:name]).messages
      else
        @messages = current_user.categories.find_by(name: "Inbox").messages
      end   
      @category = Category.new
    end
  end
end