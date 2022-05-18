# frozen_string_literal: true

class AdminController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Bulletin, policy_class: AdminPolicy
    @bulletins = Bulletin.under_moderation
  end
end
