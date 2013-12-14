require 'test_helper'

class VisitsControllerTest < ActionController::TestCase
  test "should get visits_to_workshops_index" do
    get :visits_to_workshops_index
    assert_response :success
  end

  test "should get visits_to_expositions_index" do
    get :visits_to_expositions_index
    assert_response :success
  end

  test "should get visits_to_workshops_by_subgroup" do
    get :visits_to_workshops_by_subgroup
    assert_response :success
  end

  test "should get visits_to_workshops_by_workshop" do
    get :visits_to_workshops_by_workshop
    assert_response :success
  end

  test "should get visits_to_expositions_by_subgroup" do
    get :visits_to_expositions_by_subgroup
    assert_response :success
  end

  test "should get visits_to_expositions_by_exposition" do
    get :visits_to_expositions_by_exposition
    assert_response :success
  end

  test "should get visits_to_workshops" do
    get :visits_to_workshops
    assert_response :success
  end

  test "should get visits_to_expositions" do
    get :visits_to_expositions
    assert_response :success
  end

end
