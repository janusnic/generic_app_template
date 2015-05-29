require 'test_helper'

#
class UsersLoginTest < ActionDispatch::IntegrationTest
  def login_invalid
    @u = users(:connery) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'original')
    uncheck('Remember me')
    click_button('Log in')
  end

  def login_valid_forget
    @u = users(:connery) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'goldfinger')
    uncheck('Remember me')
    click_button('Log in')
  end

  def login_remember
    @u = users(:connery) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'goldfinger')
    check('Remember me')
    click_button('Log in')
  end

  def logout
    click_on('Logout')
  end

  test 'login with invalid information' do
    login_invalid
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u)
    page.has_no_link? destroy_user_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login with valid information, no remembering' do
    login_valid_forget
    assert_equal(current_path, root_path)
    page.has_no_button?('Sign in')
    page.has_no_link? new_user_session_path
    page.has_link? destroy_user_session_path
    page.has_link? user_path(@u)
    assert_text 'You are logged in.'
    logout
  end

  test 'logging out' do
    login_valid_forget
    logout
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u)
    page.has_no_link? destroy_user_session_path
  end

  # NOTE: only makes sure that the login process is successful
  test 'login with remembering' do
    login_remember
    assert_equal(current_path, root_path)
    page.has_no_button?('Sign in')
    page.has_no_link? new_user_session_path
    page.has_link? destroy_user_session_path
    page.has_link? user_path(@u)
    assert_text 'You are logged in.'
    logout
  end
end
