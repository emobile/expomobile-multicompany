require 'test_helper'

class OffertsControllerTest < ActionController::TestCase
  setup do
    @offert = offerts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:offerts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create offert" do
    assert_difference('Offert.count') do
      post :create, offert: { description: @offert.description, end_date: @offert.end_date, expositor_id: @offert.expositor_id, price: @offert.price, price: @offert.price, start_date: @offert.start_date }
    end

    assert_redirected_to offert_path(assigns(:offert))
  end

  test "should show offert" do
    get :show, id: @offert
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @offert
    assert_response :success
  end

  test "should update offert" do
    put :update, id: @offert, offert: { description: @offert.description, end_date: @offert.end_date, expositor_id: @offert.expositor_id, price: @offert.price, price: @offert.price, start_date: @offert.start_date }
    assert_redirected_to offert_path(assigns(:offert))
  end

  test "should destroy offert" do
    assert_difference('Offert.count', -1) do
      delete :destroy, id: @offert
    end

    assert_redirected_to offerts_path
  end
end
