require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "should get new" do
    get :signup
    assert_response :success
  end

end
