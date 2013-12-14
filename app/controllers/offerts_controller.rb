class OffertsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @offerts = Offert.where(:event_id => session[:current_event_id]).order('id').paginate(:per_page => 10, :page => params[:page])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offerts }
    end
  end

  # GET /offerts/1
  # GET /offerts/1.json
  def show
    @offert = Offert.find(params[:id])
    if @offert.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to offerts_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offert }
    end
  end

  # GET /offerts/new
  # GET /offerts/new.json
  def new
    @offert = Offert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offert }
    end
  end

  # GET /offerts/1/edit
  def edit
    @offert = Offert.find(params[:id])
    if @offert.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to offerts_path and return
    end
  end

  # POST /offerts
  # POST /offerts.json
  def create
    
    unless params[:offert][:start_date].nil?
      params[:offert][:start_date] = DateTime.strptime(params[:offert][:start_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:offert][:start_date]) rescue ArgumentError) == ArgumentError)
    end
    
    unless params[:offert][:end_date].nil?
      params[:offert][:end_date] = DateTime.strptime(params[:offert][:end_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:offert][:end_date]) rescue ArgumentError) == ArgumentError)
    end
    
    @offert = Offert.new(params[:offert])

    respond_to do |format|
      if @offert.save
        format.html { redirect_to @offert, notice: t(:successfully_created) }
        format.json { render json: @offert, status: :created, location: @offert }
      else
        format.html { render action: "new" }
        format.json { render json: @offert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offerts/1
  # PUT /offerts/1.json
  def update
    @offert = Offert.find(params[:id])

    respond_to do |format|
      
      unless params[:offert][:start_date].nil?
        params[:offert][:start_date] = DateTime.strptime(params[:offert][:start_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:offert][:start_date]) rescue ArgumentError) == ArgumentError)
      end
    
      unless params[:offert][:end_date].nil?
        params[:offert][:end_date] = DateTime.strptime(params[:offert][:end_date], "%d/%m/%Y %I:%M%p") unless ((DateTime.parse(params[:offert][:end_date]) rescue ArgumentError) == ArgumentError)
      end
    
      if @offert.update_attributes(params[:offert])
        format.html { redirect_to @offert, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offerts/1
  # DELETE /offerts/1.json
  def destroy
    @offert = Offert.find(params[:id])
    @offert.destroy

    respond_to do |format|
      format.html { redirect_to offerts_url }
      format.json { head :no_content }
    end
  end
end
