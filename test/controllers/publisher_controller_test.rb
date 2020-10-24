require 'test_helper'

class PublisherControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get publisher_index_url
    assert_response :success
  end

  test "should get show" do
    get publisher_show_url
    assert_response :success
  end

end
