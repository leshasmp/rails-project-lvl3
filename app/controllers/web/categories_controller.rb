# frozen_string_literal: true

class Web::CategoriesController < Web::ApplicationController
  before_action :set_category, except: %i[index create new]
  after_action :verify_authorized

  def index
    authorize Category
    @categories = Category.all
  end

  def new
    @category = Category.new
    authorize @category
  end

  def edit
    authorize @category
  end

  def create
    authorize Category
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @category

    if @category.update(category_params)
      redirect_to categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @category
    @category.destroy

    redirect_to categories_path, notice: t('.success')
  end

  private

  def set_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
