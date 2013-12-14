class HoursController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @hours = Hour.where(:event_id => session[:current_event_id]).order('start_date DESC').paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hours }
    end
  end

  # GET /hours/1
  # GET /hours/1.json
  def show
    @hour = Hour.find(params[:id])
    if @hour.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to hours_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hour }
    end
  end

  # GET /hours/new
  # GET /hours/new.json
  def new
    @hour = Hour.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hour }
    end
  end

  # GET /hours/1/edit
  def edit
    @hour = Hour.find(params[:id])
    if @hour.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to hours_path and return
    end
  end

  # POST /hours
  # POST /hours.json
  def create

    unless params[:hour][:start_date].nil?
      params[:hour][:start_date] = DateTime.strptime(params[:hour][:start_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:hour][:start_date]) rescue ArgumentError) == ArgumentError)
    end
    
    unless params[:hour][:end_date].nil?
      params[:hour][:end_date] = DateTime.strptime(params[:hour][:end_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:hour][:end_date]) rescue ArgumentError) == ArgumentError)
    end
    
    p params[:hour][:start_date]
    p params[:hour][:end_date]
    sleep 5
    @hour = Hour.new(params[:hour])

    respond_to do |format|
      if @hour.save
        format.html { redirect_to @hour, notice: t(:successfully_created) }
        format.json { render json: @hour, status: :created, location: @hour }
      else
        format.html { render action: "new" }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hours/1
  # PUT /hours/1.json
  def update
    Hour.action = "update"
    @hour = Hour.find(params[:id])

    respond_to do |format|
    
      unless params[:hour][:start_date].nil?
        params[:hour][:start_date] = DateTime.strptime(params[:hour][:start_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:hour][:start_date]) rescue ArgumentError) == ArgumentError)
      end
    
      unless params[:hour][:end_date].nil?
        params[:hour][:end_date] = DateTime.strptime(params[:hour][:end_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:hour][:end_date]) rescue ArgumentError) == ArgumentError)
      end
      
      if @hour.update_attributes(params[:hour])
        format.html { redirect_to @hour, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hours/1
  # DELETE /hours/1.json
  def destroy
    @hour = Hour.find(params[:id])
    @deleted = @hour.destroy
    flash[:error] = t("hour.hour_cant_be_destroyed") if !@deleted

    respond_to do |format|
      format.html { redirect_to hours_url }
      format.json { head :no_content }
    end
  end
end
