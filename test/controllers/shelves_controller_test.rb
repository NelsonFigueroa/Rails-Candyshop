require 'test_helper'

class ShelvesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get shelves_index_url
    assert_response :success
  end

end
