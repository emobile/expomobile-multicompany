require 'test_helper'

class ScheduleControllerTest < ActionController::TestCase
  test "should get associate_workshop_group" do
    get :associate_workshop_group
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
