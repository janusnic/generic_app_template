require 'test_helper'

#
class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:connery) # From test/fixtures/user.yml
  end

  test 'login with invalid information' do
    get new_user_session_path
    assert_template 'sessions/new'
    post user_session_path, session: { email: '', password: '' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information' do
    get new_user_session_path
    post user_session_path, session: { email: @user.email, password: 'goldfinger' }
    assert_template '/'
    puts @user.id
    puts new_user_session_path
    puts destroy_user_session_path
    puts user_path(@user)
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', user_path(@user)
  end
end
