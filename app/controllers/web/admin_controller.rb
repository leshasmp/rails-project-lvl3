# frozen_string_literal: true

class Web::AdminController < Web::ApplicationController
  after_action :verify_authorized

  def index
    authorize Bulletin, policy_class: AdminPolicy
    @bulletins = Bulletin.under_moderation
  end
end
