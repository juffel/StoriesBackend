require 'test_helper'

class AudioControllerTest < ActionController::TestCase
  test "should get put_here" do
    get :put_here
    assert_response :success
  end

end
