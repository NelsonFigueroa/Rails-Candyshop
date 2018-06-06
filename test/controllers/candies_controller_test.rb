require 'test_helper'

class CandiesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get candies_index_url
    assert_response :success
  end

end
