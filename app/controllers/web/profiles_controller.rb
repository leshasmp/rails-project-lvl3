# frozen_string_literal: true

class Web::ProfilesController < Web::ApplicationController
  after_action :verify_authorized

  def show
    authorize Bulletin, policy_class: ProfilesPolicy
    @q = current_user.bulletins.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end
end
