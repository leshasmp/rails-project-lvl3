# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  helper_method :current_user, :logged_in?

  def callback
    if User.find_by email: user_params[:email]
      update
    else
      create
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in @user
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, flash: { error: t('.error') }
    end
  end

  def update
    @user = User.find_by email: user_params[:email]
    if @user.update user_params
      sign_in @user
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, flash: { error: t('.error') }
    end
  end

  def sign_out
    session.delete(:user_id)
    session.clear
    redirect_to root_path, notice: t('.success')
  end

  def user_params
    {
      email: request.env['omniauth.auth'][:info][:email].downcase,
      name: request.env['omniauth.auth'][:info][:name]
    }
  end
end
