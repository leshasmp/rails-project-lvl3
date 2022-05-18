# frozen_string_literal: true

class ProfileController < ApplicationController
  after_action :verify_authorized

  def index
    authorize Bulletin
    @q = current_user.bulletins.order('created_at DESC').ransack(params[:query])
    @bulletins = @q.result.page(params[:page])
  end
end
