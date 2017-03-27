module Authorize
  class CategoriesController < ApplicationController
    before_action :authorize

    def index
      @categories = current_user.categories
    end

    def show
      @category = current_user.categories.find(params[:id])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      @category.user_id = current_user.id
      if(current_user.categories.find_by(name: @category.name).nil?)
        @category.save
      end  
    end

    private
    
    def category_params
      params.require(:category).permit(:name, :id)
    end
  end
end