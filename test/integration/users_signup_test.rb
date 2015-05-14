require 'test_helper'

#
class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post user_registration_path, user: { last_name:  '',
        first_name: '',
        email: 'user@invalid',
        password: 'foo',
        password_confirmation: 'bar' }
    end
    assert_template 'new'
  end

  test 'valid signup information' do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post_via_redirect user_registration_path, user: { last_name: 'Higgins',
        first_name: 'Jonathan',
        email: 'higgins@example.com',
        password: 'higgy_baby',
        password_confirmation: 'higgy_baby' }
    end
    assert_template 'home'
  end
end
