require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  
  setup do
    @admin_user = User.create(username: "testUser", email: "testUser@email.com", password: "password", admin: true)
  end

  test "get user info from form and signup new user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "TestUser1", password: "password", email: "testuser1@email.com" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "TestUser1", response.body
  end

  test "get user info from form and reject signup new user" do
    get "/signup"
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: {  user: { username: "testUser", password: "", email: "testuser1@email.com" } }
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
