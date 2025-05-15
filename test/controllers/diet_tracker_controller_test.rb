require "test_helper"

class DietTrackerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get diet_tracker_index_url
    assert_response :success
  end
end
