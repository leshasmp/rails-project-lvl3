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
    sign_in @admin
  end

  test 'guest cant get index' do
    sign_in @user

    get admin_categories_url
    assert_redirected_to root_path
  end

  test 'should get index' do
    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'should get new' do
    get new_admin_category_url
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_category_url(@category)
    assert_response :success
  end

  test 'should create category' do
    post admin_categories_url, params: { category: @attrs }

    category = Category.find_by @attrs

    assert { category }
    assert_redirected_to admin_categories_url
  end

  test 'should update category' do
    patch admin_category_url(@category), params: { category: @attrs }

    category = Category.find_by @attrs

    assert { @category.id == category.id }
    assert_redirected_to admin_categories_url
  end

  test 'should destroy category' do
    delete admin_category_url(@category)

    assert { !Category.exists? @category.id }

    assert_redirected_to admin_categories_url
  end
end
