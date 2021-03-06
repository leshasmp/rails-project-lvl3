# frozen_string_literal: true

require 'test_helper'

class Web::Admin::BulletinsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users :admin
    @bulletin = bulletins :one
  end

  test 'guest cant get index' do
    get admin_bulletins_url
    assert_redirected_to root_path
  end

  test 'under_moderation on published' do
    bulletin = bulletins :under_moderation
    sign_in @admin
    patch publish_admin_bulletin_url(bulletin)

    assert_response :redirect

    bulletin.reload
    assert { bulletin.published? }
  end

  test 'under_moderation on rejected' do
    sign_in @admin
    bulletin = bulletins :under_moderation
    patch reject_admin_bulletin_url(bulletin)

    assert_response :redirect

    bulletin.reload
    assert { bulletin.rejected? }
  end

  test 'on archive' do
    sign_in @admin
    patch archive_admin_bulletin_url(@bulletin)

    assert_response :redirect

    @bulletin.reload
    assert { @bulletin.archived? }
  end
end
