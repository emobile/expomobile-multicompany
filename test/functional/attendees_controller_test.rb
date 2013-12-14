require 'test_helper'

class AttendeesControllerTest < ActionController::TestCase
  setup do
    @attendee = attendees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendee" do
    assert_difference('Attendee.count') do
      post :create, attendee: { a_cellphone: @attendee.a_cellphone, a_chat: @attendee.a_chat, a_email: @attendee.a_email, a_is_director: @attendee.a_is_director, a_market_segment: @attendee.a_market_segment, a_name: @attendee.a_name, a_num_employees: @attendee.a_num_employees, a_other_line: @attendee.a_other_line, a_platform: @attendee.a_platform, a_radio_nextel: @attendee.a_radio_nextel, a_sec_line: @attendee.a_sec_line, a_tel_nextel: @attendee.a_tel_nextel, a_web: @attendee.a_web, e_city: @attendee.e_city, e_colony: @attendee.e_colony, e_ext_number: @attendee.e_ext_number, e_int_number: @attendee.e_int_number, e_lada: @attendee.e_lada, e_main_line: @attendee.e_main_line, e_municipality: @attendee.e_municipality, e_name: @attendee.e_name, e_phone: @attendee.e_phone, e_rfc: @attendee.e_rfc, e_state: @attendee.e_state, e_street: @attendee.e_street, e_tradename: @attendee.e_tradename, e_zip_code: @attendee.e_zip_code }
    end

    assert_redirected_to attendee_path(assigns(:attendee))
  end

  test "should show attendee" do
    get :show, id: @attendee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attendee
    assert_response :success
  end

  test "should update attendee" do
    put :update, id: @attendee, attendee: { a_cellphone: @attendee.a_cellphone, a_chat: @attendee.a_chat, a_email: @attendee.a_email, a_is_director: @attendee.a_is_director, a_market_segment: @attendee.a_market_segment, a_name: @attendee.a_name, a_num_employees: @attendee.a_num_employees, a_other_line: @attendee.a_other_line, a_platform: @attendee.a_platform, a_radio_nextel: @attendee.a_radio_nextel, a_sec_line: @attendee.a_sec_line, a_tel_nextel: @attendee.a_tel_nextel, a_web: @attendee.a_web, e_city: @attendee.e_city, e_colony: @attendee.e_colony, e_ext_number: @attendee.e_ext_number, e_int_number: @attendee.e_int_number, e_lada: @attendee.e_lada, e_main_line: @attendee.e_main_line, e_municipality: @attendee.e_municipality, e_name: @attendee.e_name, e_phone: @attendee.e_phone, e_rfc: @attendee.e_rfc, e_state: @attendee.e_state, e_street: @attendee.e_street, e_tradename: @attendee.e_tradename, e_zip_code: @attendee.e_zip_code }
    assert_redirected_to attendee_path(assigns(:attendee))
  end

  test "should destroy attendee" do
    assert_difference('Attendee.count', -1) do
      delete :destroy, id: @attendee
    end

    assert_redirected_to attendees_path
  end
end
