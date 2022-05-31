# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end

  def publish
    @bulletin = Bulletin.find params[:id]

    if @bulletin.publish!
      redirect_to admin_path, notice: t('web.bulletins.publish.success')
    else
      redirect_to admin_path, flash: { error: t('web.bulletins.state.error') }
    end
  end

  def reject
    @bulletin = Bulletin.find params[:id]

    if @bulletin.reject!
      redirect_to admin_path, notice: t('web.bulletins.reject.success')
    else
      redirect_to admin_path, flash: { error: t('web.bulletins.state.error') }
    end
  end

  def archive
    @bulletin = Bulletin.find params[:id]

    if @bulletin.archive!
      redirect_to admin_path, notice: t('web.bulletins.archive.success')
    else
      redirect_to admin_path, flash: { error: t('web.bulletins.state.error') }
    end
  end
end
