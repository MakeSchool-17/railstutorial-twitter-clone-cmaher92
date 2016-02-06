require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "John Doe", email: "john@doe.com")
                    (password: "connor", password_confirmation: "connor")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not  @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup # creates a duplicate user
    duplicate_user.email = @user.email.upcase
    @user.save # attempts a save on the database
    assert_not duplicate_user.valid? # assures that validity is false
  end

  test "password should be present (nonblank)" do
  @user.password = @user.password_confirmation = " " * 6
  assert_not @user.valid?
end

test "password should have a minimum length" do
  @user.password = @user.password_confirmation = "a" * 5
  assert_not @user.valid?
end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
end
