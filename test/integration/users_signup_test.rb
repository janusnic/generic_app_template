require 'test_helper'

#
class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    visit new_user_registration_path
    fill_in('Last name', with: 'Higgins')
    fill_in('First name', with: 'Jonathan')
    fill_in('Email', with: 'jonathan_higgins@example.com')
    fill_in('Password', with: 'Robin Masters')
    fill_in('Password confirmation', with: 'Zeus and Apollo')
    click_button('Sign up')
    assert_text 'prohibited this user from being saved'
    u1 = User.find_by(email: 'jonathan_higgins@example.com')
    assert_nil u1
  end

  test 'valid signup information' do
    visit new_user_registration_path
    fill_in('Last name', with: 'Higgins')
    fill_in('First name', with: 'Jonathan')
    fill_in('Email', with: 'jonathan_higgins@example.com')
    fill_in('Password', with: 'Higgy Baby')
    fill_in('Password confirmation', with: 'Higgy Baby')
    click_button('Sign up')
    assert_text 'confirmation link has been sent to your email address'
    u1 = User.find_by(email: 'jonathan_higgins@example.com')
    assert_equal u1.last_name.to_s, 'Higgins'
    assert_equal u1.first_name.to_s, 'Jonathan'
    assert_nil u1.confirmed_at
  end
end
