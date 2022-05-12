# frozen_string_literal: true

module AuthConcern
  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    redirect_to root_path if current_user.nil?
  end
end
