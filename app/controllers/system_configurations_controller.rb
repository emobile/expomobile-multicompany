class SystemConfigurationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /system_configurations/1
  # GET /system_configurations/1.json
  def show
    @system_configuration = SystemConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @system_configuration }
    end
  end

  # GET /system_configurations/1/edit
  def edit
    @system_configuration = SystemConfiguration.find(params[:id])
  end

  # PUT /system_configurations/1
  # PUT /system_configurations/1.json
  def update
    @system_configuration = SystemConfiguration.find(params[:id])

    respond_to do |format|
      if @system_configuration.update_attributes(params[:system_configuration])
        format.html { redirect_to @system_configuration, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @system_configuration.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def select_event
    unless params[:event_id].blank?
      session[:current_event_id] = params[:event_id]
      flash[:notice] = t("system_configuration.event_changed")
    end
    redirect_to root_path
  end

end