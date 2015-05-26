require 'test_helper'
include ApplicationHelper

#
class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @u = users(:connery) # From test/fixtures/user.yml
  end

  test 'login with invalid information' do
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'original')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?("Sign in")
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u)
    page.has_no_link? destroy_user_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login with valid information, no remembering' do
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'goldfinger')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, root_path)
    page.has_no_button?("Sign in")
    page.has_no_link? new_user_session_path
    page.has_link? destroy_user_session_path
    page.has_link? (user_path(@u))
    assert_text 'You are logged in.'
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
