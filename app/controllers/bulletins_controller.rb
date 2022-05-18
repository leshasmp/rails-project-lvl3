# frozen_string_literal: true

class BulletinsController < ApplicationController
  before_action :set_bulletin, except: %i[index create new]
  after_action :verify_authorized, except: %i[show]

  def index
    authorize Bulletin
    @q = Bulletin.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end

  def show; end

  def new
    @bulletin = Bulletin.new
    authorize @bulletin
  end

  def edit
    authorize @bulletin
  end

  def create
    authorize Bulletin
    @bulletin = current_user.bulletins.new(bulletin_params)

    if @bulletin.save
      redirect_to root_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderation
    authorize @bulletin

    if @bulletin.to_moderation!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, status: :unprocessable_entity
    end
  end

  def publish
    authorize @bulletin

    if @bulletin.publish!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, status: :unprocessable_entity
    end
  end

  def reject
    authorize @bulletin

    if @bulletin.reject!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, status: :unprocessable_entity
    end
  end

  def archive
    authorize @bulletin

    if @bulletin.archive!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, status: :unprocessable_entity
    end
  end

  private

  def set_bulletin
    @bulletin = Bulletin.find params[:id]
  end

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
