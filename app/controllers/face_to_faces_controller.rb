class FaceToFacesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @face_to_faces = FaceToFace.where(:event_id => session[:current_event_id]).order('id DESC').paginate(:per_page => 10, :page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @face_to_faces }
    end
  end

  # GET /face_to_faces/1
  # GET /face_to_faces/1.json
  def show
    @face_to_face = FaceToFace.find(params[:id])
    if @face_to_face.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to face_to_faces_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @face_to_face }
    end
  end

  # GET /face_to_faces/new
  # GET /face_to_faces/new.json
  def new
    @face_to_face = FaceToFace.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @face_to_face }
    end
  end

  # GET /face_to_faces/1/edit
  def edit
    @face_to_face = FaceToFace.find(params[:id])
    if @face_to_face.event_id != session[:current_event_id].to_i
      flash[:error] = t(:not_correspond)
      redirect_to face_to_faces_path and return
    end
    
  end

  # POST /face_to_faces
  # POST /face_to_faces.json
  def create
    @face_to_face = FaceToFace.new(params[:face_to_face])

    respond_to do |format|
      if @face_to_face.save
        format.html { redirect_to @face_to_face, notice: t(:successfully_created) }
        format.json { render json: @face_to_face, status: :created, location: @face_to_face }
      else
        format.html { render action: "new" }
        format.json { render json: @face_to_face.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /face_to_faces/1
  # PUT /face_to_faces/1.json
  def update
    FaceToFace.action = "update"
    @face_to_face = FaceToFace.find(params[:id])

    respond_to do |format|
      if @face_to_face.update_attributes(params[:face_to_face])
        format.html { redirect_to @face_to_face, notice: t(:successfully_updated) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @face_to_face.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /face_to_faces/1
  # DELETE /face_to_faces/1.json
  def destroy
    @face_to_face = FaceToFace.find(params[:id])
    @face_to_face.destroy

    respond_to do |format|
      format.html { redirect_to face_to_faces_url }
      format.json { head :no_content }
    end
  end
  
  def get_interviewee
    @interviewee = Sponsor.where(:name => params[:name]).select([:contact, :job]).first
    @interviewee = Exhibitor.where(:name => params[:name]).select([:contact, :job]).first if @interviewee.blank?
    
    render json: @interviewee
  end
  
  def generate_diary
    @face_to_faces = FaceToFace.where(:int_contact => params[:int_contact])
    
    render layout: false
  end
end