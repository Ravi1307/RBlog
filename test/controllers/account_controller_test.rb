require 'test_helper'

class AccountControllerTest < ActionController::TestCase
  test "should get sign_in" do
    get :sign_in
    assert_response :success
  end

  test "should get sign_up" do
    get :sign_up
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

end
