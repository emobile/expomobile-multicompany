class DiariesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @diaries = Diary.where(:event_id => session[:current_event_id]).order('id DESC').paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diaries }
    end
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
    @diary = Diary.find(params[:id])
    if @diary.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to diaries_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diary }
    end
  end

  # GET /diaries/new
  # GET /diaries/new.json
  def new
    @diary = Diary.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diary }
    end
  end

  # GET /diaries/1/edit
  def edit
    @diary = Diary.find(params[:id])
    if @diary.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to diaries_path and return
    end
  end

  # POST /diaries
  # POST /diaries.json
  def create
    @diary = Diary.new(params[:diary])

    respond_to do |format|
      if @diary.save
        format.html { redirect_to @diary, notice: t(:successfully_created) }
        format.json { render json: @diary, status: :created, location: @diary }
      else
        format.html { render action: "new" }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /diaries/1
  # PUT /diaries/1.json
  def update
    @diary = Diary.find(params[:id])

    respond_to do |format|
      if @diary.update_attributes(params[:diary])
        format.html { redirect_to @diary, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.json
  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy

    respond_to do |format|
      format.html { redirect_to diaries_url }
      format.json { head :no_content }
    end
  end
end
