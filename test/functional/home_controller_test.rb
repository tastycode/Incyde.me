require 'test_helper'
class HomeControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "should show homepage" do
    get :index
    assert_response :success
  end

  test "home page should show posts when logged in" do
    user=users(:marcus)
    sign_in user
    get :index
    assert assigns["posts"].length == 2
  end
end
