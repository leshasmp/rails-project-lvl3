# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
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

  test 'signed admin can get index' do
    sign_in @admin

    get admin_bulletins_url
    assert_response :success
  end

  test 'signin user cant get index' do
    sign_in @user

    get admin_bulletins_url
    assert_redirected_to root_path
  end

  test 'guest cant get index' do
    get admin_bulletins_url
    assert_redirected_to root_path
  end
end
