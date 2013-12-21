class MailTemplatesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @mail_templates = MailTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mail_templates }
    end
  end

  # GET /mail_templates/1
  # GET /mail_templates/1.json
  def show
    @mail_template = MailTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mail_template }
    end
  end

  # GET /mail_templates/1/edit
  def edit
    @mail_template = MailTemplate.find(params[:id])
    if @mail_template.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to mail_templates_path and return
    end
  end
  
  # PUT /mail_templates/1
  # PUT /mail_templates/1.json
  def update
    @mail_template = MailTemplate.find(params[:id])

    respond_to do |format|
      if @mail_template.update_attributes(params[:mail_template])
        format.html { redirect_to @mail_template, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mail_template.errors, status: :unprocessable_entity }
      end
    end
  end  
  
end