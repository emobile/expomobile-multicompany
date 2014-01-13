class MobileServicesController < ApplicationController
  before_filter :detect_platform
  before_filter :load_event, :except => [:get_attendee_id, :get_attendee_nip]
  #skip_before_filter :verify_authenticity_token, :only => [:register_visit_to_workshop]
  respond_to :json
  layout false

  def get_attendee_id
    I18n.locale = params[:language]
    session[:language] = params[:language]
    @attendee_id = params[:attendee_id]
    
    if @attendee_id =~ /\A[A-Z]{2}\d{4}\z/
      token_for_id = @attendee_id[0, 2]
      @event = Event.find_by_token_for_id(token_for_id)
      @attendee = @event.attendees.find_by_attendee_id(@attendee_id)
      session[:current_event_id] = @event.id

      if !@attendee.nil?
        @nip = @attendee.nip
      
        while @nip.nil?
          random_value = Array.new(4) {[*'0'..'9', *'a'..'z'].sample}.join
          @exists = @event.nips.find_by_nip(random_value)
        
          if @exists.nil?
            @nip = Nip.create(:nip => random_value, :attendee_id => @attendee.id, :event_id => @event.id)
          end
        end
      
#        @times_sent = (@nip.times_sent.nil?) ? 0: @nip.times_sent
#      
#        if @times_sent < 10
          @can_send_email = false
          @can_send_email = ((Time.now - @nip.sent) >= 0) unless @nip.sent.nil?
      
          if @nip.sent.nil? || @can_send_email
            @name = @attendee.a_name
            @email = @attendee.a_email
            @subgroup_name = @attendee.subgroup.name
            @group_name = @attendee.subgroup.group.name
            @subgroup_leader = @attendee.subgroup.leader
            @domain = @email.gsub(/^.*@/, "")
            @enterprise = @attendee.e_name
            @phone = @attendee.e_phone
            @address = "#{@attendee.e_street} #{@attendee.e_ext_number} #{@attendee.e_colony}"
    
            if !@attendee.a_email.nil?
            
              if AttendeeMailer.send_nip(@attendee, @nip).deliver!
                @nip.update_attributes(:sent => Time.now, :times_sent => (@nip.times_sent.nil?) ? 1: @nip.times_sent += 1 )
                @msg = { name: @name, email: @email, subgroup_name: @subgroup_name, group_name: @group_name, subgroup_leader: @subgroup_leader, domain: @domain, enterprise: @enterprise, phone: @phone, address: @address, msg: t("atten.nip_sended", :email => @email), sent: "ok" }
              else
                @msg = { name: @name, email: @email, subgroup_name: @subgroup_name, group_name: @group_name, subgroup_leader: @subgroup_leader, domain: @domain, enterprise: @enterprise, phone: @phone, address: @address, msg: t("errors.atten_email_dont_sended"), sent: "no" }
              end
              
            else
              @msg = { name: @name, email: @email, subgroup_name: @subgroup_name, group_name: @group_name, subgroup_leader: @subgroup_leader, domain: @domain, enterprise: @enterprise, phone: @phone, address: @address, msg: t("errors.atten_email_not_registered"), sent: "no" }
            end
      
          else
            @msg = { name: nil, email: @email, subgroup_name: @subgroup_name, group_name: @group_name, subgroup_leader: @subgroup_leader, domain: @domain, enterprise: @enterprise, phone: @phone, address: @address, msg: t("errors.atten_email_already_sended"), sent: "no" }
          end
        
#        else
#          @msg = { name: nil, email: @email, subgroup_name: @subgroup_name, group_name: @group_name, subgroup_leader: @subgroup_leader, domain: @domain, enterprise: @enterprise, phone: @phone, address: @address, msg: t("errors.atten_email_maximum_sends"), sent: "no" }
#        end
    
      else
        @msg = { name: nil, email: nil, subgroup_name: nil, group_name: nil, subgroup_leader: nil, domain: nil, enterprise: nil, phone: nil, address: nil, msg: t("errors.atten_not_exists"), sent: "no" }
      end
      
    else
      @msg = { name: nil, email: nil, subgroup_name: nil, group_name: nil, subgroup_leader: nil, enterprise: nil, phone: nil, address: nil, domain: nil, msg: t("errors.atten_invalid_id"), sent: "no" }
    end
    
    render json: @msg
  end
  
  def get_attendee_nip
    @attendee_id = params[:attendee_id].split("-")[0]
    
    if @attendee_id =~ /\A[A-Z]{2}\d{4}\z/
      token_for_id = @attendee_id[0, 2]
      @event = Event.find_by_token_for_id(token_for_id)
      @attendee = @event.attendees.find_by_attendee_id(@attendee_id)
      
      if !@attendee.nil?
        if params[:nip] =~ /\A[0-9a-z]{4}\z/
          @nip = @attendee.nip
      
          if params[:nip] == @nip.nip
            @msg = { access: "ok", msg: t("atten.access_ok") }
            session[:attendee_id] = @attendee.id
          else
            @msg = { access: "no", msg: t("errors.atten_nips_dont_match") }
          end
      
        else
          @msg = { access: "no", msg: t("errors.atten_invalid_nip") }
        end
      
      else
        @msg = { access: "no", msg: t("errors.atten_not_exists"), sent: "no" }
      end
      
    else
      @msg = { access: "no", msg: t("errors.atten_invalid_id") }
    end
    
    render json: @msg
  end
  
  def index_offerts
    
    if !session[:attendee_id].blank?
      
      if params[:exhibitor_id] =~ /\A\d+\z/
        @offerts = @event.offerts.where(:exhibitor_id => params[:exhibitor_id])
      else
        @offerts = @event.offerts.all
      end
      
      @offerts.map { |o| o[:exhibitor_name] = o.exhibitor.name }
      @offerts.sort_by! { |o| o[:exhibitor_name] }
      render json: @offerts
    end
    
  end
  
  def show_offert
    
    if !session[:attendee_id].blank?
      @offert = Offert.find_by_id(params[:offert_id])
      @offert[:exhibitor_name] = @offert.exhibitor.social_reason
      render json: @offert
    end

  end
  
  def index_sponsors
    
    if !session[:attendee_id].blank?
      @sponsors = @event.sponsors.order(:social_reason)
      @sponsors.each {|s| s[:mobile_logo_url] = s.logo.url(:mobile)}
      
      render json: @sponsors
    end
    
  end
  
  def show_sponsor
    
    if !session[:attendee_id].blank?
      @sponsor = Sponsor.find_by_id(params[:sponsor_id])
      @sponsor[:mobile_logo_url] = @sponsor.logo.url(:mobile)
      
      render json: @sponsor
    end

  end
  
  def index_conferences
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @conferences = @event.conferences.order("start_date DESC").select {|c| c.start_date.strftime('%d/%m/%Y') == params[:day]}
        @conferences.each do |c|
          c[:mobile_photo_url] = (c.photo.url(:mobile) == "/assets/missing.jpg")? "": c.photo.url(:mobile)
        end
        
        render json: @conferences
      end
      
    end
    
  end
  
  def show_conference
    
    if !session[:attendee_id].blank?
      @conference = Conference.find_by_id(params[:conference_id])
      @conference[:mobile_photo_url] = (@conference.photo.url(:mobile) == "/assets/missing.jpg")? "": @conference.photo.url(:mobile)
      
      render json: @conference
    end

  end
  
  def index_activities
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @activities = @event.activities.order("start_date DESC").select {|a| a.start_date.strftime('%d/%m/%Y') == params[:day]}
        
        render json: @activities
      end
      
    end
    
  end
  
  def show_activity
    
    if !session[:attendee_id].blank?
      @activity = Activity.find_by_id(params[:activity_id])
      render json: @activity
    end

  end
  
  def index_diaries
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @diaries = @event.diaries.order("event_date DESC").select {|d| d.event_date.strftime('%d/%m/%Y') == params[:day]}
        
        render json: @diaries
      end
      
    end
    
  end
  
  def show_diary
    
    if !session[:attendee_id].blank?
      @diary = Diary.find_by_id(params[:diary_id])
      render json: @diary
    end

  end
  
  def index_face_to_faces
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @face_to_faces = FaceToFace.where(:attendee_id => session[:attendee_id]).order(:start_date).select {|f| f.start_date.strftime('%d/%m/%Y') == params[:day]}
        @face_to_faces.each do |f|
          f[:attendee_name] = f.attendee.a_name
          f[:attendee_enterprise_name] = f.attendee.e_name
          f[:attendee_email] = f.attendee.a_email
          f[:attendee_phone] = f.attendee.e_phone
        end
        render json: @face_to_faces
      end
      
    end
    
  end
  
  def show_face_to_face
    
    if !session[:attendee_id].blank?
      @face_to_face = FaceToFace.find_by_id_and_attendee_id(params[:face_to_face_id], session[:attendee_id])
      @face_to_face[:attendee_name] = @face_to_face.attendee.a_name
      @face_to_face[:attendee_enterprise_name] = @face_to_face.attendee.e_name
      @face_to_face[:attendee_email] = @face_to_face.attendee.a_email
      @face_to_face[:attendee_phone] = @face_to_face.attendee.e_phone
      render json: @face_to_face
    end

  end
  
  def index_exhibitors
    
    if !session[:attendee_id].blank?

      if params[:with_offerts] == "1"
        @exhibitors = @event.exhibitors.joins("RIGHT OUTER JOIN offerts o ON exhibitors.id = o.exhibitor_id").order(:social_reason).uniq
        @exhibitors.each {|e| e[:mobile_logo_url] = e.logo.url(:mobile)}
      else
        @exhibitors = @event.exhibitors.order(:social_reason)
        @exhibitors.each {|e| e[:mobile_logo_url] = e.logo.url(:mobile)}
      end
      
      render json: @exhibitors
    end
    
  end
  
  def show_exhibitor
    
    if !session[:attendee_id].blank?

      @exhibitor = Exhibitor.find_by_id(params[:exhibitor_id])
      @exhibitor[:mobile_logo_url] = @exhibitor.logo.url(:mobile)
      
      render json: @exhibitor
    end
    
  end
  
  def index_workshop_days
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @days = @attendee.hours.order("start_date ASC").pluck(:start_date).map{ |s| s.strftime("%d/%m/%Y") }.uniq
        render json: @days
      end
      
    end
    
  end
  
  def index_exposition_days
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @days = @event.expositions.pluck(:start_date).map{ |s| s.strftime("%d/%m/%Y") }.uniq
        render json: @days
      end
      
    end
    
  end
  
  def index_conference_days
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @days = @event.conferences.pluck(:start_date).map{ |c| c.strftime("%d/%m/%Y") }.uniq
        render json: @days.sort_by { |w| w["start_date"] }
      end
      
    end
    
  end
  
  def index_activity_days
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @days = @event.activities.pluck(:start_date).map{ |a| a.strftime("%d/%m/%Y") }.uniq
        render json: @days
      end
      
    end
    
  end
  
  def index_diary_days
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @days = @event.diaries.pluck(:event_date).map{ |d| d.strftime("%d/%m/%Y") }.uniq
        render json: @days
      end
      
    end
    
  end
  
  def index_face_to_face_days
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      unless @attendee.nil?
        @days = FaceToFace.where(:attendee_id => session[:attendee_id]).pluck(:start_date).map{ |f| f.strftime("%d/%m/%Y") }.uniq
        render json: @days
      end
      
    end
    
  end
  
  def index_workshops

    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])

      unless @attendee.nil?
        @workshops = @attendee.workshops
        @workshops.each do |w|
          @hour = Hour
          .joins("INNER JOIN schedules s ON hours.id = s.hour_id")
          .joins("INNER JOIN workshops w ON s.workshop_id = w.id")
          .where("w.id = #{w.id} AND s.subgroup_id = #{@attendee.subgroup_id}")
          .select { |h| h.start_date.strftime('%d/%m/%Y') == params[:day] }.first
          if !@hour.nil?
            w[:start_date] = @hour.start_date
            w[:start_hour] = @hour.start_hour
            w[:end_date] = @hour.start_date
            w[:end_hour] = @hour.end_hour
            w[:room_name] = w.room.name
            w[:room_key] = w.room.room_key
          end
        end
        
        @workshops.reject! { |w| w[:start_date].nil? }
        @workshops.sort_by! { |w| w[:start_date] }
        @workshops.reverse!
        
        render json: @workshops
      end
      
    end
    
  end
  
  def index_expositions
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @expositions = @event.expositions.order("start_date DESC").select {|e| e.start_date.strftime('%d/%m/%Y') == params[:day]}
        @expositions.each do |e|
          e[:start_day] = e.start_date.strftime('%d/%m/%Y')
          e[:end_day] = e.end_date.strftime('%d/%m/%Y')
          e[:start_hour] = e.start_date.strftime('%I:%M%p')
          e[:end_hour] = e.end_date.strftime('%I:%M%p')
        end
        
        render json: @expositions
      end
      
    end
    
  end
  
  def index_expositions_names
    
    if !session[:attendee_id].blank?
      @attendee = Attendee.find_by_id(session[:attendee_id])
      
      unless @attendee.nil?
        @expositions = @event.expositions.select(:name)
        render json: @expositions
      end
      
    end
    
  end
  
  def register_visit_to_workshop
    current_time = Time.now.in_time_zone(@event.time_zone).time
    
    if !session[:attendee_id].blank?

      if params[:key] =~ /\A[a-z0-9]{3}\z/
        @workshop = @event.workshops.find_by_workshop_key(params[:key])
        @hour = Hour.joins("INNER JOIN schedules s ON hours.id = s.hour_id")
        .joins("INNER JOIN subgroups su ON s.subgroup_id = su.id")
        .joins("INNER JOIN attendees a ON su.id = a.subgroup_id")
        .where("s.workshop_id = ? AND a.id = ?", @workshop.id, session[:attendee_id]).first

        if !@hour.nil?
          @visit_registered = AttendeeWorkshop.find_by_attendee_id_and_workshop_id(session[:attendee_id], @workshop.id)
          
          if @visit_registered.nil?

            if current_time >= @hour.start_date && current_time < (@hour.end_date + @event.workshop_tolerance.minutes + 1.minute)
              AttendeeWorkshop.create(attendee_id: session[:attendee_id], workshop_id: @workshop.id)
              @msg = { success: "yes", msg: t(:visit_registered_to_workshop, :workshop_name => @workshop.name ) }
            else
              @msg = { success: "no", msg: t(:visit_not_registered) }
            end
          
          else
            @msg = { success: "no", msg: t(:visit_already_registered) }
          end
          
        else
          @msg = { success: "no", msg: t("errors.workshop_not_assigned") }
        end
        
      else
        @msg = { success: "no", msg: t("errors.invalid_workshop_key") }
      end

    end
    
    render json: @msg
  end
  
  def register_visit_to_exposition

    if !session[:attendee_id].blank?

      if params[:key] =~ /\A[a-z0-9]{3}\z/
        @exhibitor = @event.exhibitors.find_by_exposition_key(params[:key])

        if !@exhibitor.nil?
          @visit_registered = AttendeeExposition.find_by_attendee_id_and_exhibitor_id(session[:attendee_id], @exhibitor.id)
          
          if @visit_registered.nil?
            AttendeeExposition.create(attendee_id: session[:attendee_id], exhibitor_id: @exhibitor.id)
            @msg = { success: "yes", msg: t(:visit_registered_to_exhibitor, :exhibitor_name => @exhibitor.name) }
          else
            @msg = { success: "no", msg: t(:visit_already_registered) }
          end
          
        else
          @msg = { success: "no", msg: t("errors.exhibitor_not_assigned") }
        end
          
      else
        @msg = { success: "no", msg: t("errors.invalid_exhibitor_key") }
      end

    end
    
    render json: @msg
  end

  def rate
    
    if !session[:attendee_id].blank?

      if params[:value] =~ /\A[1-3]\z/
        Rating.create(value: params[:value], comment: params[:comment])
        @msg = { success: "yes", msg: t(:rate_thank_you) }
      end
      
    end
  
    render json: @msg
  end
  
  #  def detect_platform
  #    if request.env['HTTP_USER_AGENT'] == ""
  #      access = true
  #    else
  #      access = false
  #    end
  #    unless access
  #      flash[:alert] = t("no_access")
  #      redirect_to root_path
  #    end
  #  end

  def load_event
    @event = Event.find_by_id(session[:current_event_id])
  end
  
  def get_enabled_options
    @event = Event.find_by_id(1)
    @options = { :has_activity => @event.has_activity, :has_conference => @event.has_conference, :has_facetoface => @event.has_facetoface, :has_offert => @event.has_offert, :has_workshop => @event.has_workshop }
    render json: @options
  end
  
end