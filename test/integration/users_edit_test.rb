require 'test_helper'

#
class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @u = users(:connery) # From test/fixtures/user.yml
  end

  test 'unsuccessful edit' do
    # Login
    get new_user_session_path
    post_via_redirect user_session_path, user: {
      email: 'sean_connery@example.com', password: 'goldfinger',
      remember_me: '0' }

    # Edit user information
    get edit_user_registration_path(@u)
    patch user_registration_path, user: { last_name: 'Powers',
      first_name: '', email: 'foo@invalid', password: 'foo',
      password_confirmation: 'bar' }
    assert_template 'edit'
  end

  test 'successful edit' do
    # Login
    get new_user_session_path
    post_via_redirect user_session_path, user: { email: @u.email,
      password: 'goldfinger', remember_me: '0' }

    # Edit user information
    get edit_user_registration_path(@u)
    patch user_registration_path, user: { last_name: 'Powers',
      first_name: 'Austin' }
    assert_template '/'
  end
end
