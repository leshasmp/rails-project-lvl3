# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
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

  test 'signin user should get new' do
    sign_in @user

    get new_bulletin_url
    assert_response :success
  end

  test 'guest cant get new bulletin' do
    get new_bulletin_url

    assert_redirected_to root_path
  end

  test 'signed user can create bulletin' do
    sign_in @user
    post bulletins_url, params: { bulletin: @attrs }
    assert_response :redirect

    bulletin = Bulletin.find_by! title: @attrs[:title]

    assert { bulletin }
    assert_redirected_to root_path
  end

  test 'guest cant create bulletin' do
    post bulletins_url, params: { bulletin: @attrs }

    assert_redirected_to root_path
  end

  test 'author can edit' do
    sign_in @user

    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'admin can edit' do
    sign_in @admin

    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'author can update bulletin' do
    sign_in @user

    patch bulletin_url(@bulletin), params: { bulletin: @attrs }
    assert_redirected_to bulletin_url(@bulletin)
  end

  test 'admin can update bulletin' do
    sign_in @admin

    patch bulletin_url(@bulletin), params: { bulletin: @attrs }
    assert_redirected_to bulletin_url(@bulletin)
  end

  test 'not author cant update bulletin' do
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title != @attrs[:title] }
    assert_redirected_to root_path
  end
end
