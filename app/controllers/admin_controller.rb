# frozen_string_literal: true

class AdminController < ApplicationController
  def index
    @bulletins = Bulletin.under_moderation
  end
end
