require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User model" do
    user1 = User.new(name: "ted", password: "secret", email: "ted@me.com")
    assert user1.save, "user should save #{user1.errors.full_messages}"
    
    user2 = User.new(password: "secret", email: "mail@me.com")
    assert !user2.save, "user without name should not save"
    
    user3 = User.new(name: "barney", password: "secret")
    assert !user3.save, "user without email should not save"
    
    user4 = User.new(name: "ted", password: "secret", email: "teddy_westside@me.com")
    assert !user4.save, "user with taken name should not save"
    
    user5 = User.new(name: "teddy_westside", password: "secret", email: "ted@me.com")
    assert !user5.save, "user with taken email should not save"
    
    user6 = User.new(name: "teddy_westside", password: "secret", email: "ted")
    assert !user6.save, "user without valid email should not save"
  end
end
