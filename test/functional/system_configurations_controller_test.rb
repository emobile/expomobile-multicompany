require 'test_helper'

class SystemConfigurationsControllerTest < ActionController::TestCase
  setup do
    @system_configuration = system_configurations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:system_configurations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create system_configuration" do
    assert_difference('SystemConfiguration.count') do
      post :create, system_configuration: { banner: @system_configuration.banner, exposition_tolerance: @system_configuration.exposition_tolerance, logo: @system_configuration.logo, token: @system_configuration.token, workshop_tolerance: @system_configuration.workshop_tolerance }
    end

    assert_redirected_to system_configuration_path(assigns(:system_configuration))
  end

  test "should show system_configuration" do
    get :show, id: @system_configuration
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @system_configuration
    assert_response :success
  end

  test "should update system_configuration" do
    put :update, id: @system_configuration, system_configuration: { banner: @system_configuration.banner, exposition_tolerance: @system_configuration.exposition_tolerance, logo: @system_configuration.logo, token: @system_configuration.token, workshop_tolerance: @system_configuration.workshop_tolerance }
    assert_redirected_to system_configuration_path(assigns(:system_configuration))
  end

  test "should destroy system_configuration" do
    assert_difference('SystemConfiguration.count', -1) do
      delete :destroy, id: @system_configuration
    end

    assert_redirected_to system_configurations_path
  end
end
