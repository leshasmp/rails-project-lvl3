# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  before_action :set_bulletin, except: %i[index]
  after_action :verify_authorized

  def index
    authorize Bulletin, policy_class: AdminBulletinPolicy
    @q = Bulletin.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end

  def publish
    authorize @bulletin, policy_class: AdminBulletinPolicy

    if @bulletin.publish!
      redirect_to admin_index_path, notice: t('web.bulletins.publish.success')
    else
      redirect_to admin_index_path, status: :unprocessable_entity
    end
  end

  def reject
    authorize @bulletin, policy_class: AdminBulletinPolicy

    if @bulletin.reject!
      redirect_to admin_index_path, notice: t('.web.bulletins.reject.success')
    else
      redirect_to admin_index_path, status: :unprocessable_entity
    end
  end

  def archive
    authorize @bulletin, policy_class: AdminBulletinPolicy

    if @bulletin.archive!
      redirect_to profile_path, notice: t('.web.bulletins.archive.success')
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
