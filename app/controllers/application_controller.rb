# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?

  include AuthConcern
end
