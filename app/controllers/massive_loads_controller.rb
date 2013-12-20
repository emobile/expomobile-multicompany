class MassiveLoadsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  include MassiveLoadsHelper

  def index
    @massive_loads = MassiveLoad.where(:event_id => session[:current_event_id]).order('id DESC').paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @massive_loads }
    end
  end

  # GET /massive_loads/1
  # GET /massive_loads/1.json
  def show
    @massive_load = MassiveLoad.find(params[:id])
    if @massive_load.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to massive_loads_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @massive_load }
    end
  end

  # GET /massive_loads/new
  # GET /massive_loads/new.json
  def new
    @massive_load = MassiveLoad.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @massive_load }
    end
  end

  # POST /massive_loads
  # POST /massive_loads.json
  def create
    @massive_load = MassiveLoad.new(params[:massive_load])

    respond_to do |format|
      if @massive_load.save
        @has_error = false
        read_excel
        if @has_error
          flash[:error] = t("massive_load.format_error")
          MassiveLoad.destroy(@massive_load)
          redirect_to new_massive_load_path and return
        end
        format.html { redirect_to @massive_load, notice: t(:successfully_created) }
        format.json { render json: @massive_load, status: :created, location: @massive_load }
      else
        format.html { render action: "new" }
        format.json { render json: @massive_load.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /massive_loads/1
  # DELETE /massive_loads/1.json
  def destroy
    @massive_load = MassiveLoad.find(params[:id])
    @massive_load.destroy

    respond_to do |format|
      format.html { redirect_to massive_loads_url }
      format.json { head :no_content }
    end
  end
end
