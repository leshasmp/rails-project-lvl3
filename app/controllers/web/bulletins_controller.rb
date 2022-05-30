# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  after_action :verify_authorized, only: %i[show new edit create update to_moderation archive]

  def index
    @q = Bulletin.published.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end

  def show
    @bulletin = Bulletin.find params[:id]
    authorize @bulletin
  end

  def new
    @bulletin = Bulletin.new
    authorize @bulletin
  end

  def edit
    @bulletin = Bulletin.find params[:id]
    authorize @bulletin
  end

  def create
    authorize Bulletin
    @bulletin = current_user.bulletins.build(bulletin_params)

    if @bulletin.save
      redirect_to root_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find params[:id]
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderation
    @bulletin = Bulletin.find params[:id]
    authorize @bulletin

    if @bulletin.to_moderation!
      redirect_to profile_path, notice: t('web.bulletins.to_moderation.success')
    else
      redirect_to profile_path, status: :unprocessable_entity
    end
  end

  def archive
    @bulletin = Bulletin.find params[:id]
    authorize @bulletin

    if @bulletin.archive!
      redirect_to profile_path, notice: t('web.bulletins.archive.success')
    else
      redirect_to profile_path, status: :unprocessable_entity
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end
end
