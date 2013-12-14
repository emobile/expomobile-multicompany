class SchedulesController < ApplicationController
  before_filter :authenticate_user!
  
  def do_association
    @s1 = Schedule.find_by_hour_id_and_subgroup_id(params[:hour_id], params[:subgroup_id])
    @s1.destroy if !@s1.nil?
    @s2 = Schedule.find_by_workshop_id_and_subgroup_id(params[:workshop_id], params[:subgroup_id])
    @s2.destroy if !@s2.nil?
    @s3 = Schedule.find_by_hour_id_and_workshop_id(params[:hour_id], params[:workshop_id])
    @s3.destroy if !@s3.nil?
    @schedule = Schedule.new(workshop_id: params[:workshop_id], subgroup_id: params[:subgroup_id], hour_id: params[:hour_id])
    if @schedule.save
      flash[:notice] = t("schedule.created")
      flash[:schedule_start_date] = @schedule.hour.start_date
    else
      flash[:error] = t("schedule.not_created")
    end
    redirect_to schedules_associate_workshop_group_path
  end
  
  def associate_workshop_group
    @schedule = Schedule.new
  end
  
  def deallocate
    @schedule = Schedule.find(params[:schedule_id_delete])
    flash[:schedule_start_date] = @schedule.hour.start_date
    @schedule.destroy
    flash[:notice] = t("schedule.deallocation_done")
    redirect_to schedules_associate_workshop_group_path
  end
  
  def subgroup_change
    @change = false
    @schedule = Schedule.find_by_hour_id_and_workshop_id(params[:hour_id], params[:workshop_id])
    @change = @schedule.subgroup_id != params[:subgroup_id].to_i
    render json: {:change => @change}
  end
end