# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should redirect edit when not loged in' do
    get edit_users_path(@user)
    assert_not flash.empty?
    assert_redirect_to login_url
  end

  test 'should redirect update when not loged in' do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirect_to login_url
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirect_to login_url
  end
end
