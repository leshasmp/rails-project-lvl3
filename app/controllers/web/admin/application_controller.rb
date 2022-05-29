# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  include AuthConcern

  before_action :check_admin

  def check_admin
    user_not_authorized unless current_user&.admin?
  end

  private

  def user_not_authorized
    redirect_to root_path, flash: { error: t('authorization.error') }
  end
end
