require 'test_helper'

class FaceToFacesControllerTest < ActionController::TestCase
  setup do
    @face_to_face = face_to_faces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:face_to_faces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create face_to_face" do
    assert_difference('FaceToFace.count') do
      post :create, face_to_face: { app_email: @face_to_face.app_email, app_enterprise: @face_to_face.app_enterprise, app_name: @face_to_face.app_name, app_phone: @face_to_face.app_phone, end_date: @face_to_face.end_date, int_email: @face_to_face.int_email, int_enterprise: @face_to_face.int_enterprise, int_name: @face_to_face.int_name, int_phone: @face_to_face.int_phone, start_date: @face_to_face.start_date }
    end

    assert_redirected_to face_to_face_path(assigns(:face_to_face))
  end

  test "should show face_to_face" do
    get :show, id: @face_to_face
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @face_to_face
    assert_response :success
  end

  test "should update face_to_face" do
    put :update, id: @face_to_face, face_to_face: { app_email: @face_to_face.app_email, app_enterprise: @face_to_face.app_enterprise, app_name: @face_to_face.app_name, app_phone: @face_to_face.app_phone, end_date: @face_to_face.end_date, int_email: @face_to_face.int_email, int_enterprise: @face_to_face.int_enterprise, int_name: @face_to_face.int_name, int_phone: @face_to_face.int_phone, start_date: @face_to_face.start_date }
    assert_redirected_to face_to_face_path(assigns(:face_to_face))
  end

  test "should destroy face_to_face" do
    assert_difference('FaceToFace.count', -1) do
      delete :destroy, id: @face_to_face
    end

    assert_redirected_to face_to_faces_path
  end
end
