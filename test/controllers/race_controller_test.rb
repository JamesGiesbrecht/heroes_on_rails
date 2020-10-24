require 'test_helper'

class RaceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get race_index_url
    assert_response :success
  end

  test "should get show" do
    get race_show_url
    assert_response :success
  end

end
