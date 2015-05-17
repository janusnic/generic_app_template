require 'test_helper'

#
class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @u = users(:connery) # From test/fixtures/user.yml
  end

  test 'login with invalid information' do
    get new_user_session_path
    post_via_redirect user_session_path, user: { email: @u.email,
      password: 'Austin Powers', remember_me: '1' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    assert_select 'a[href=?]', new_user_session_path, count: 1
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
    assert_select 'a[href=?]', user_path(@u), count: 0
    get root_path
    assert flash.empty?
  end

  test 'login with valid information, no remembering' do
    get new_user_session_path
    post_via_redirect user_session_path, user: { email: @u.email,
      password: 'goldfinger', remember_me: '0' }
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path, count: 1
    assert_select 'a[href=?]', user_path(@u), count: 1
    assert_not flash.empty?
    get root_path
    assert flash.empty?
    assert_nil cookies['remember_user_token']
  end

  test 'logging out' do
    # Logging in
    get new_user_session_path
    post_via_redirect user_session_path, user: { email: @u.email,
      password: 'goldfinger' }
    # Logging out
    delete destroy_user_session_path
    follow_redirect!
    assert_not flash.empty?
    assert_select 'a[href=?]', new_user_session_path, count: 1
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
    assert_select 'a[href=?]', user_path(@u), count: 0
    get root_path
    assert flash.empty?
  end

  test 'login with remembering' do
    # Logging in
    get new_user_session_path
    post_via_redirect user_session_path, user: { email: @u.email,
      password: 'goldfinger', remember_me: '1' }
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path, count: 1
    assert_select 'a[href=?]', user_path(@u), count: 1
    assert_not_nil cookies['remember_user_token']
  end
end