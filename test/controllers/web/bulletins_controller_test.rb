# frozen_string_literal: true

require 'test_helper'

class Web::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users :one
    @user_two = users :two
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

    bulletin = Bulletin.find_by! title: @attrs[:title],
                                 description: @attrs[:description],
                                 category_id: @attrs[:category_id]

    assert { bulletin }
    assert_redirected_to root_path
  end

  test 'guest cant create bulletin' do
    post bulletins_url, params: { bulletin: @attrs }

    bulletin = Bulletin.find_by title: @attrs[:title],
                                description: @attrs[:description],
                                category_id: @attrs[:category_id]

    assert { bulletin.nil? }
    assert_redirected_to root_path
  end

  test 'author can edit' do
    sign_in @user

    get edit_bulletin_url(@bulletin)
    assert_response :success
  end

  test 'not author cant edit bulletin' do
    sign_in @user_two

    get edit_bulletin_url(@bulletin)
    assert_redirected_to root_path
  end

  test 'guest cant edit bulletin' do
    get edit_bulletin_url(@bulletin)
    assert_redirected_to root_path
  end

  test 'author can update bulletin' do
    sign_in @user

    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    bulletin = Bulletin.find_by! title: @attrs[:title],
                                 description: @attrs[:description],
                                 category_id: @attrs[:category_id]

    assert { @bulletin.id == bulletin.id }
    assert_redirected_to bulletin_url(@bulletin)
  end

  test 'not author cant update bulletin' do
    patch bulletin_url(@bulletin), params: { bulletin: @attrs }

    @bulletin.reload

    assert { @bulletin.title != @attrs[:title] }
    assert_redirected_to root_path
  end

  test 'draft on under moderation' do
    sign_in @user
    patch to_moderation_bulletin_url(@bulletin)

    assert_response :redirect

    @bulletin.reload
    assert { @bulletin.under_moderation? }
  end

  test 'draft on archive' do
    sign_in @user
    patch archive_bulletin_url(@bulletin)

    assert_response :redirect

    @bulletin.reload
    assert { @bulletin.archived? }
  end
end
