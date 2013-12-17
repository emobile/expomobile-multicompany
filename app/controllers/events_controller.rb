class EventsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @events = Event.order('id DESC').paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @event.users.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    params[:event][:r_name] = "#{params[:event][:users_attributes]["0"][:first_name]} #{params[:event][:users_attributes]["0"][:last_name]}"
    params[:event][:r_email] = params[:event][:users_attributes]["0"][:email]
    params[:event][:r_phone] = params[:event][:users_attributes]["0"][:phone]
    params[:event][:r_work_street] = params[:event][:users_attributes]["0"][:street]
    params[:event][:r_work_street_number] = params[:event][:users_attributes]["0"][:street_number]
    params[:event][:r_work_colony] = params[:event][:users_attributes]["0"][:colony]
    params[:event][:r_work_zip] = params[:event][:users_attributes]["0"][:zip]
    params[:event][:r_city] = params[:event][:users_attributes]["0"][:city]
    params[:event][:r_state] = params[:event][:users_attributes]["0"][:state]
    params[:event][:r_country] = params[:event][:users_attributes]["0"][:country] 
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        @group = Group.create(name: t("group.main_group"), event_id: session[:current_event_id])
        Subgroup.create(name: t("subgroup.main_subgroup"), leader: "Leader", subgroup_key: "S1", group_id: @group.id, event_id: session[:current_event_id])
        format.html { redirect_to @event, notice: t(:successfully_created)}
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        I18n.locale = @event.language if current_user.role.is_admin
        session[:language] = @event.language
        format.html { redirect_to @event, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end