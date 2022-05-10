# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  helper_method :current_user, :logged_in?
  before_action :auth, only: [:callback]

  def callback
    email = auth[:info][:email].downcase
    user = User.find_by(email: email)

    if user.nil?
      user = User.new(email: email, name: auth[:info][:nickname])
      user.save
    end

    sign_in user
    redirect_to root_path
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
