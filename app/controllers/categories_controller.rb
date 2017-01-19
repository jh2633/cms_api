class CategoriesController < ApplicationController

  def create
    @category = Category.new(category_params)

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

private

  def category_params
    params.require(:category).permit(:title)
  end
end
