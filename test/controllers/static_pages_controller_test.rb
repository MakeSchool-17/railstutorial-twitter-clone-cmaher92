require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase

  test "should get home" do
    # send a get request to home
    get :home
    # ensure we receive a success response from the server
    assert_response :success
    # checks to see if there is a title page
    assert_select "title", "Ruby on Rails Tutorial Sample App"

  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
    get :about
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

end
