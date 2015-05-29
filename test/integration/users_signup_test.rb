require 'test_helper'

#
class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'valid signup information' do
    visit new_user_registration_path
    fill_in('Last name', with: 'Higgins')
    fill_in('First name', with: 'Jonathan')
    fill_in('Email', with: 'jonathan_higgins@example.com')
    fill_in('Password', with: 'Higgy Baby')
    fill_in('Password confirmation', with: 'Higgy Baby')
    click_button('Sign up')
    u1 = User.find_by(email: 'jonathan_higgins@example.com')
    assert_equal u1.last_name.to_s, 'Higgins'
    assert_equal u1.first_name.to_s, 'Jonathan'
    assert_nil u1.confirmed_at
    assert_text 'confirmation link has been sent to your email address'
    # url_conf = "http://localhost:3000/users/confirmation?confirmation_token=#{u1.confirmation_token}"
    # puts url_conf
    # visit url_conf
    # assert_text 'Your email address has been successfully confirmed.'
    
    # assert_equal 1, ActionMailer::Base.deliveries.size
    # u1 = assigns(:user)
    # assert_not u1.activated?
    # Try to log in before activation.
    # log_in_as(u1)
    # assert_not is_logged_in?
    # Invalid activation token
    # get edit_account_activation_path("invalid token")
    # assert_not is_logged_in?
    # get edit_account_activation_path(user.activation_token, email: 'wrong')
    # assert_not is_logged_in?
    # get edit_account_activation_path(user.activation_token, email: user.email)
    # assert user.reload.activated?
    # follow_redirect!
    # assert_template 'users/show'
    # assert is_logged_in?
  end
end
