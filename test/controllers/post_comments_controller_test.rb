require "test_helper"

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get post_comments_new_url
    assert_response :success
  end

  test "should get show" do
    get post_comments_show_url
    assert_response :success
  end

  test "should get edit" do
    get post_comments_edit_url
    assert_response :success
  end

  test "should get index" do
    get post_comments_index_url
    assert_response :success
  end
end
