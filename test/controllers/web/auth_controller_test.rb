# frozen_string_literal: true

require 'test_helper'

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    @admin = users :admin
    @bulletin = bulletins :one
    @category = categories :one
    @attrs = {
      title: Faker::Book.title,
      description: Faker::Books::Dune.quote,
      category_id: @category.id,
      image: fixture_file_upload('hexlet.png', 'image/png')
    }
  end

  test 'check github auth' do
    post auth_request_path('github')
    assert_response :redirect
  end

  test 'create' do
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: Faker::Internet.email,
        name: Faker::Name.first_name
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
    assert_response :redirect

    user = User.find_by!(email: auth_hash[:info][:email].downcase)

    assert user
    assert signed_in?
  end

  test 'sign_out' do
    sign_in @user
    assert { signed_in? }

    delete auth_logout_url

    assert_redirected_to root_path
    assert { session[:user_id].nil? }
  end
end
