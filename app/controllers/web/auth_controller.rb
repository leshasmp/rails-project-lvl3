# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  helper_method :current_user, :logged_in?

  def callback
    @user = User.find_or_initialize_by(email: user_params[:email])
    @user[:name] = user_params[:name]
    if @user.save
      sign_in @user
      redirect_to root_path, notice: t('.success')
    else
      redirect_to root_path, flash: { error: t('.error') }
    end
  end

  def logout
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
