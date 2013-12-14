class ExpositionsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @expositions = Exposition.where(:event_id => session[:current_event_id]).order('id DESC').paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expositions }
    end
  end

  # GET /expositions/1
  # GET /expositions/1.json
  def show
    @exposition = Exposition.find(params[:id])
    if @exposition.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to expositions_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exposition }
    end
  end

  # GET /expositions/new
  # GET /expositions/new.json
  def new
    @exposition = Exposition.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exposition }
    end
  end

  # GET /expositions/1/edit
  def edit
    @exposition = Exposition.find(params[:id])
    if @exposition.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to expositions_path and return
    end
  end

  # POST /expositions
  # POST /expositions.json
  def create
    
    unless params[:exposition][:start_date].nil?
      params[:exposition][:start_date] = DateTime.strptime(params[:exposition][:start_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:exposition][:start_date]) rescue ArgumentError) == ArgumentError)
    end
    
    unless params[:exposition][:end_date].nil?
      params[:exposition][:end_date] = DateTime.strptime(params[:exposition][:end_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:exposition][:end_date]) rescue ArgumentError) == ArgumentError)
    end
    
    @exposition = Exposition.new(params[:exposition])

    respond_to do |format|
      if @exposition.save
        format.html { redirect_to @exposition, notice: t(:successfully_created) }
        format.json { render json: @exposition, status: :created, location: @exposition }
      else
        format.html { render action: "new" }
        format.json { render json: @exposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /expositions/1
  # PUT /expositions/1.json
  def update
    Exposition.action = "update"
    @exposition = Exposition.find(params[:id])

    respond_to do |format|
      
      unless params[:exposition][:start_date].nil?
        params[:exposition][:start_date] = DateTime.strptime(params[:exposition][:start_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:exposition][:start_date]) rescue ArgumentError) == ArgumentError)
      end
    
      unless params[:exposition][:end_date].nil?
        params[:exposition][:end_date] = DateTime.strptime(params[:exposition][:end_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:exposition][:end_date]) rescue ArgumentError) == ArgumentError)
      end
      
      if @exposition.update_attributes(params[:exposition])
        format.html { redirect_to @exposition, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exposition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expositions/1
  # DELETE /expositions/1.json
  def destroy
    @exposition = Exposition.find(params[:id])
    @exposition.destroy

    respond_to do |format|
      format.html { redirect_to expositions_url }
      format.json { head :no_content }
    end
  end
  
  def set_tolerance 
    if !params[:tolerance].blank?
      if SystemConfiguration.first.update_attributes(exposition_tolerance: params[:tolerance])
        flash[:notice] = t(:tolerance_set_successfully)
      else
        flash[:error] = t(:tolerance_not_set)
      end
    end
    redirect_to expositions_path
  end
end