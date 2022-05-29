# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end

  def publish
    @bulletin = Bulletin.find params[:id]

    @bulletin.publish!
    redirect_to admin_path, notice: t('web.bulletins.publish.success')
  end

  def reject
    @bulletin = Bulletin.find params[:id]

    @bulletin.reject!
    redirect_to admin_path, notice: t('web.bulletins.reject.success')
  end

  def archive
    @bulletin = Bulletin.find params[:id]

    @bulletin.archive!
    redirect_to admin_bulletins_path, notice: t('web.bulletins.archive.success')
  end
end
