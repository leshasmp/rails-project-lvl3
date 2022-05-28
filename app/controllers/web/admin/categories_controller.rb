# frozen_string_literal: true

class Web::Admin::CategoriesController < Web::Admin::ApplicationController
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
    @category = Category.find params[:id]
    authorize @category
  end

  def create
    authorize Category
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find params[:id]
    authorize @category

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find params[:id]
    authorize @category
    @category.destroy

    redirect_to admin_categories_path, notice: t('.success')
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
