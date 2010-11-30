require 'test_helper'

class GmapControllerTest < ActionController::TestCase
  test "should get crawl" do
    get :crawl
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
