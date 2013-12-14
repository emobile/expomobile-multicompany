require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { banner: @event.banner, exposition_tolerance: @event.exposition_tolerance, has_activity: @event.has_activity, has_conference: @event.has_conference, has_facetoface: @event.has_facetoface, has_offert: @event.has_offert, has_workshop: @event.has_workshop, language: @event.language, logo: @event.logo, name: @event.name, r_city: @event.r_city, r_country: @event.r_country, r_email: @event.r_email, r_enterprise: @event.r_enterprise, r_job: @event.r_job, r_name: @event.r_name, r_phone: @event.r_phone, r_social_reason: @event.r_social_reason, r_state: @event.r_state, r_work_colony: @event.r_work_colony, r_work_street: @event.r_work_street, r_work_street_number: @event.r_work_street_number, r_work_zip: @event.r_work_zip, time_zone: @event.time_zone, workshop_tolerance: @event.workshop_tolerance }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    put :update, id: @event, event: { banner: @event.banner, exposition_tolerance: @event.exposition_tolerance, has_activity: @event.has_activity, has_conference: @event.has_conference, has_facetoface: @event.has_facetoface, has_offert: @event.has_offert, has_workshop: @event.has_workshop, language: @event.language, logo: @event.logo, name: @event.name, r_city: @event.r_city, r_country: @event.r_country, r_email: @event.r_email, r_enterprise: @event.r_enterprise, r_job: @event.r_job, r_name: @event.r_name, r_phone: @event.r_phone, r_social_reason: @event.r_social_reason, r_state: @event.r_state, r_work_colony: @event.r_work_colony, r_work_street: @event.r_work_street, r_work_street_number: @event.r_work_street_number, r_work_zip: @event.r_work_zip, time_zone: @event.time_zone, workshop_tolerance: @event.workshop_tolerance }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
