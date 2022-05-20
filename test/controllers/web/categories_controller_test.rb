# frozen_string_literal: true

require 'test_helper'

class Web::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users :admin
    @user = users :one
    @category = categories :one
    @attrs = {
      name: Faker::Book.title
    }
  end

  test 'signed admin can get index' do
    sign_in @admin

    get categories_url
    assert_response :success
  end

  test 'signin user cant get index' do
    sign_in @user

    get categories_url
    assert_redirected_to root_path
  end

  test 'guest cant get index' do
    get categories_url
    assert_redirected_to root_path
  end

  test 'signed admin can get new' do
    sign_in @admin

    get new_category_url
    assert_response :success
  end

  test 'signin user cant get new' do
    sign_in @user

    get new_category_url
    assert_redirected_to root_path
  end

  test 'guest cant get new' do
    get new_category_url

    assert_redirected_to root_path
  end

  test 'signed admin can get edit' do
    sign_in @admin

    get edit_category_url(@category)
    assert_response :success
  end

  test 'signin user cant get edit' do
    sign_in @user

    get edit_category_url(@category)
    assert_redirected_to root_path
  end

  test 'guest cant get edit' do
    get edit_category_url(@category)

    assert_redirected_to root_path
  end

  test 'signed admin create category' do
    sign_in @admin

    post categories_url, params: { category: @attrs }
    assert_response :redirect

    category = Category.find_by! name: @attrs[:name]

    assert { category }
    assert_redirected_to categories_path
  end

  test 'signin user cant create category' do
    sign_in @user

    post categories_url, params: { category: @attrs }
    assert_redirected_to root_path
  end

  test 'guest cant create category' do
    post categories_url, params: { category: @attrs }

    assert_redirected_to root_path
  end

  test 'signed admin can update category' do
    sign_in @admin

    patch category_url(@category), params: { category: @attrs }
    assert_redirected_to categories_url
  end

  test 'signin user cant update category' do
    sign_in @user

    patch category_url(@category), params: { category: @attrs }
    assert_redirected_to root_path
  end

  test 'guest cant update category' do
    patch category_url(@category), params: { category: @attrs }

    @category.reload

    assert { @category.name != @attrs[:name] }
    assert_redirected_to root_path
  end
end
