require 'test_helper'

#
class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: '007@example.com',
      password: 'bond_james_bond', password_confirmation: 'bond_james_bond')
  end

  test 'should be valid' do
    assert @user.valid?
  end
end
