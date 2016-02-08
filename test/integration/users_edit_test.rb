require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "update with invalid information" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), user: {name: "asdfasdf",
                                   email: "asdfasdf",
                                   password: "foo",
                                   password_confirmation: "bar"}
    assert_template 'users/edit'
  end

 test "succesful edit with friendly forwarding" do
   get edit_user_path(@user)
   log_in_as(@user)
   assert_redirected_to edit_user_path(@user)
   name = "Foo Bar"
   email = "foo@bar.com"
   patch user_path(@user), user: {name: name,
                                  email: email,
                                  password: "",
                                  password_confirmation: ""}
   assert_not flash.empty? # this only passes if flash is empty
   assert_redirected_to @user # /users/1
   @user.reload # refreshes @user object
   assert_equal @user.name, name # verify they have been updated
   assert_equal @user.email, email
 end
end
