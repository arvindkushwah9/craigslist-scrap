require 'test_helper'

class ScrappersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get scrappers_index_url
    assert_response :success
  end

end
