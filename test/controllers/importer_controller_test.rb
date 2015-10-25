require 'test_helper'

class ImporterControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
