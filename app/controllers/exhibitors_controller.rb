class ExhibitorsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    if params[:with_offerts] == "1"
      @exhibitors = Exhibitor.joins("RIGHT OUTER JOIN offerts o ON exhibitors.id = o.exhibitor_id").where(:event_id => session[:current_event_id]).uniq
      @exhibitors.each {|e| e[:mobile_logo_url] = e.logo.url(:mobile)}
    else
      @exhibitors = Exhibitor.where(:event_id => session[:current_event_id]).order('id DESC').paginate(:per_page => 10, :page => params[:page])
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exhibitors }
    end
  end

  # GET /exhibitors/1
  # GET /exhibitors/1.json
  def show
    @exhibitor = Exhibitor.find(params[:id])
    if @exhibitor.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to exhibitors_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exhibitor }
    end
  end

  # GET /exhibitors/new
  # GET /exhibitors/new.json
  def new
    @exhibitor = Exhibitor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @exhibitor }
    end
  end

  # GET /exhibitors/1/edit
  def edit
    @exhibitor = Exhibitor.find(params[:id])
    if @exhibitor.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to exhibitors_path and return
    end
  end

  # POST /exhibitors
  # POST /exhibitors.json
  def create
    @exhibitor = Exhibitor.new(params[:exhibitor])
    
    while @exhibitor.exposition_key.nil?
      random_value = Array.new(3) {[*'0'..'9', *'a'..'z'].sample}.join
      @exists = Workshop.find_by_workshop_key(random_value) || Exhibitor.find_by_exposition_key(random_value)
        
      if @exists.nil?
        @exhibitor.exposition_key = random_value
      end
    end

    respond_to do |format|
      if @exhibitor.save
        format.html { redirect_to @exhibitor, notice: t(:successfully_created) }
        format.json { render json: @exhibitor, status: :created, location: @exhibitor }
      else
        format.html { render action: "new" }
        format.json { render json: @exhibitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /exhibitors/1
  # PUT /exhibitors/1.json
  def update
    @exhibitor = Exhibitor.find(params[:id])

    respond_to do |format|
      if @exhibitor.update_attributes(params[:exhibitor])
        format.html { redirect_to @exhibitor, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @exhibitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exhibitors/1
  # DELETE /exhibitors/1.json
  def destroy
    @exhibitor = Exhibitor.find(params[:id])
    @exhibitor.destroy

    respond_to do |format|
      format.html { redirect_to exhibitors_url }
      format.json { head :no_content }
    end
  end
end
