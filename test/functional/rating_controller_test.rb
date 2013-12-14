require 'test_helper'

class RatingControllerTest < ActionController::TestCase
  test "should get show_rating" do
    get :show_rating
    assert_response :success
  end

end
