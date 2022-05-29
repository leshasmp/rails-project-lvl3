# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
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

    get admin_categories_url
    assert_response :success
  end

  test 'signin user cant get index' do
    sign_in @user

    get admin_categories_url
    assert_redirected_to root_path
  end

  test 'guest cant get index' do
    get admin_categories_url
    assert_redirected_to root_path
  end

  test 'signed admin can get new' do
    sign_in @admin

    get new_admin_category_url
    assert_response :success
  end

  test 'signin user cant get new' do
    sign_in @user

    get new_admin_category_url
    assert_redirected_to root_path
  end

  test 'guest cant get new' do
    get new_admin_category_url

    assert_redirected_to root_path
  end

  test 'signed admin can get edit' do
    sign_in @admin

    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'signin user cant get edit' do
    sign_in @user

    get edit_admin_category_url(@category)
    assert_redirected_to root_path
  end

  test 'guest cant get edit' do
    get edit_admin_category_url(@category)

    assert_redirected_to root_path
  end

  test 'signed admin create category' do
    sign_in @admin

    post admin_categories_url, params: { category: @attrs }

    category = Category.find_by! name: @attrs[:name]

    assert { category }
    assert_redirected_to admin_categories_url
  end

  test 'signin user cant create category' do
    sign_in @user

    post admin_categories_url, params: { category: @attrs }

    category = Category.find_by name: @attrs[:name]

    assert { category.nil? }
    assert_redirected_to root_path
  end

  test 'guest cant create category' do
    post admin_categories_url, params: { category: @attrs }

    assert_redirected_to root_path
  end

  test 'signed admin can update category' do
    sign_in @admin

    patch admin_category_url(@category), params: { category: @attrs }

    category = Category.find_by! name: @attrs[:name]

    assert { @category.id == category.id }
    assert_redirected_to admin_categories_url
  end

  test 'signin user cant update category' do
    sign_in @user

    patch admin_category_url(@category), params: { category: @attrs }

    category = Category.find_by name: @attrs[:name]

    assert { category.nil? }
    assert_redirected_to root_path
  end

  test 'guest cant update category' do
    patch admin_category_url(@category), params: { category: @attrs }

    category = Category.find_by name: @attrs[:name]

    assert { category.nil? }

    assert_redirected_to root_path
  end
end
