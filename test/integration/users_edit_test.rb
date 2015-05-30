require 'test_helper'

#
class UsersEditTest < ActionDispatch::IntegrationTest
  test 'login and logout with valid information, no remembering' do
    # Create user
    visit new_user_registration_path
    fill_in('Last name', with: 'Curie')
    fill_in('First name', with: 'Marie')
    fill_in('Email', with: 'mcurie@example.com')
    fill_in('Password', with: 'polonium')
    fill_in('Password confirmation', with: 'polonium')
    click_button('Sign up')
    @u1 = User.find_by(email: 'mcurie@example.com')

    # Confirm user
    @u1.confirmed_at = Time.now
    @u1.confirmation_token = nil
    @u1.save

    # Login
    visit new_user_session_path
    fill_in('Email', with: 'mcurie@example.com')
    fill_in('Password', with: 'polonium')
    uncheck('Remember me')
    click_button('Log in')
    assert_text 'You are logged in.'
    assert_equal(current_path, root_path)
    page.has_no_button?('Sign in')
    page.has_no_link? new_user_session_path
    page.has_link? destroy_user_session_path
    page.has_link? user_path(@u1)

    # Logout
    click_on('Logout')
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u1)
    page.has_no_link? destroy_user_session_path
  end

  # NOTE: only makes sure that the login process is successful
  test 'login and logout with valid information, with remembering' do
    # Create user
    visit new_user_registration_path
    fill_in('Last name', with: 'Carter')
    fill_in('First name', with: 'Landon')
    fill_in('Email', with: 'lcarter@example.com')
    fill_in('Password', with: 'I was changed!')
    fill_in('Password confirmation', with: 'I was changed!')
    click_button('Sign up')
    @u4 = User.find_by(email: 'lcarter@example.com')

    # Confirm user
    @u4.confirmed_at = Time.now
    @u4.confirmation_token = nil
    @u4.save

    # Login
    visit new_user_session_path
    fill_in('Email', with: 'lcarter@example.com')
    fill_in('Password', with: 'I was changed!')
    check('Remember me')
    click_button('Log in')
    assert_text 'You are logged in.'
    assert_equal(current_path, root_path)
    page.has_no_button?('Sign in')
    page.has_no_link? new_user_session_path
    page.has_link? destroy_user_session_path
    page.has_link? user_path(@u4)

    # Logout
    click_on('Logout')
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u4)
    page.has_no_link? destroy_user_session_path
  end
end
