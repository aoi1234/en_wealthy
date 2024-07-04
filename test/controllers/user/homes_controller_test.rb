require "test_helper"

class User::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get user_homes_new_url
    assert_response :success
  end

  test "should get about" do
    get user_homes_about_url
    assert_response :success
  end
end
