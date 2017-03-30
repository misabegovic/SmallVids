module Authorize
  class CategoriesController < ApplicationController
    before_action :authorize
    
    def create
      @category = Category.new(category_params)
      @category.user_id = current_user.id
      condition = current_user.categories
                              .find_by(name: @category.name)
                              .nil?
      @category.save if condition 
    end

    private
    
    def category_params
      params.require(:category).permit(:name, :id)
    end
  end
end