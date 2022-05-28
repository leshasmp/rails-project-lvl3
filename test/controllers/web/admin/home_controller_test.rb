# frozen_string_literal: true

require 'test_helper'

class Web::Admin::HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users :admin
    @user = users :one
  end

  test 'signed admin can get index' do
    sign_in @admin

    get admin_url
    assert_response :success
  end

  test 'user cant get index' do
    sign_in @user

    get admin_url
    assert_redirected_to root_path
  end

  test 'guest cant get index' do
    get admin_url
    assert_redirected_to root_path
  end
end
