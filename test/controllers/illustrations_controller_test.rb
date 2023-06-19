require "test_helper"

class IllustrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get illustrations_new_url
    assert_response :success
  end

  test "should get show" do
    get illustrations_show_url
    assert_response :success
  end

  test "should get edit" do
    get illustrations_edit_url
    assert_response :success
  end

  test "should get index" do
    get illustrations_index_url
    assert_response :success
  end
end
