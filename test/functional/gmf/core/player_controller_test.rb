require 'test_helper'

class Gmf::Core::PlayerControllerTest < ActionController::TestCase

  #before do
  #  sign_in :user, @user
  #end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get delete" do
    get :delete
    assert_response :success
  end

end
