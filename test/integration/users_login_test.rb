require 'test_helper'

#
class UsersLoginTest < ActionDispatch::IntegrationTest
  test 'login with invalid information, no remembering' do
    @u1 = users(:connery) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'original')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u1)
    page.has_no_link? destroy_user_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login with invalid information, with remembering' do
    @u1 = users(:connery) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'sean_connery@example.com')
    fill_in('Password', with: 'original')
    check('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u1)
    page.has_no_link? destroy_user_session_path
    assert_text 'Invalid email or password.'
  end

  test 'login for unconfirmed user, no remembering' do
    @u2 = users(:lazenby) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'george_lazenby@example.com')
    fill_in('Password', with: 'ohmss1969')
    uncheck('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u2)
    page.has_no_link? destroy_user_session_path
    assert_text 'You have to confirm your email address'
  end

  test 'login for unconfirmed user, with remembering' do
    @u2 = users(:lazenby) # From test/fixtures/user.yml
    visit new_user_session_path
    fill_in('Email', with: 'george_lazenby@example.com')
    fill_in('Password', with: 'ohmss1969')
    check('Remember me')
    click_button('Log in')
    assert_equal(current_path, new_user_session_path)
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u2)
    page.has_no_link? destroy_user_session_path
    assert_text 'You have to confirm your email address'
  end

  test 'login and logout with valid information, no remembering' do
    # Create user
    visit new_user_registration_path
    fill_in('Last name', with: 'Sullivan')
    fill_in('First name', with: 'Jamie')
    fill_in('Email', with: 'jsullivan@example.com')
    fill_in('Password', with: 'Only Hope')
    fill_in('Password confirmation', with: 'Only Hope')
    click_button('Sign up')
    @u3 = User.find_by(email: 'jsullivan@example.com')

    # Confirm user
    @u3.confirmed_at = Time.now
    @u3.confirmation_token = nil
    @u3.save

    # Login
    visit new_user_session_path
    fill_in('Email', with: 'jsullivan@example.com')
    fill_in('Password', with: 'Only Hope')
    uncheck('Remember me')
    click_button('Log in')
    assert_text 'You are logged in.'
    assert_equal(current_path, root_path)
    page.has_no_button?('Sign in')
    page.has_no_link? new_user_session_path
    page.has_link? destroy_user_session_path
    page.has_link? user_path(@u3)
    assert_nil @u3.remember_created_at

    # Logout
    click_on('Logout')
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u3)
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
    assert_nil @u4.remember_created_at

    # Logout
    click_on('Logout')
    page.has_button?('Sign in')
    page.has_link? new_user_session_path
    page.has_no_link? user_path(@u4)
    page.has_no_link? destroy_user_session_path
  end
end
