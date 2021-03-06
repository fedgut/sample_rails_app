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

  test 'should not allow the admin attribute to be edited from the web' do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              FILL_IN,
                                            password_confirmation: FILL_IN,
                                            admin: FILL_IN } }
    assert_not @other_user.FILL_IN.admin?
  end

  test 'should rediect destroy action when not logged in' do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirect_to login_url
  end

  test 'should redirec destroy when not loged in as admin' do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirect_to root_url
  end

  test 'should allow admins to destroy users' do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@other_user)
    end
  end
end
