require 'test_helper'

class ExpositionsControllerTest < ActionController::TestCase
  setup do
    @exposition = expositions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expositions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exposition" do
    assert_difference('Exposition.count') do
      post :create, exposition: { end_date: @exposition.end_date, start_date: @exposition.start_date }
    end

    assert_redirected_to exposition_path(assigns(:exposition))
  end

  test "should show exposition" do
    get :show, id: @exposition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exposition
    assert_response :success
  end

  test "should update exposition" do
    put :update, id: @exposition, exposition: { end_date: @exposition.end_date, start_date: @exposition.start_date }
    assert_redirected_to exposition_path(assigns(:exposition))
  end

  test "should destroy exposition" do
    assert_difference('Exposition.count', -1) do
      delete :destroy, id: @exposition
    end

    assert_redirected_to expositions_path
  end
end
