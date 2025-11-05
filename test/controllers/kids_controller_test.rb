require "test_helper"

class KidsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get kids_new_url
    assert_response :success
  end

  test "should get create" do
    get kids_create_url
    assert_response :success
  end

  test "should get index" do
    get kids_index_url
    assert_response :success
  end
end
