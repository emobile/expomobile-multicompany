require 'test_helper'

class MassiveLoadsControllerTest < ActionController::TestCase
  setup do
    @massive_load = massive_loads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:massive_loads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create massive_load" do
    assert_difference('MassiveLoad.count') do
      post :create, massive_load: { excel_file: @massive_load.excel_file }
    end

    assert_redirected_to massive_load_path(assigns(:massive_load))
  end

  test "should show massive_load" do
    get :show, id: @massive_load
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @massive_load
    assert_response :success
  end

  test "should update massive_load" do
    put :update, id: @massive_load, massive_load: { excel_file: @massive_load.excel_file }
    assert_redirected_to massive_load_path(assigns(:massive_load))
  end

  test "should destroy massive_load" do
    assert_difference('MassiveLoad.count', -1) do
      delete :destroy, id: @massive_load
    end

    assert_redirected_to massive_loads_path
  end
end
