class ScheduleController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_access, only: [:create, :delete, :download]
  require 'will_paginate/array'

  def show
    if current_user.is_admin?
      @schedules = Schedule.all.to_a
      @a = true
    elsif current_user.is_instructor?
      name = Instructor.find(current_user.rank_id).name
      @schedules = Schedule.where('supervisor=? OR president=? OR secretary=? OR member=? OR examiner=?',
                                  name, name, name, name, name)
    else #student
      name = Student.find(current_user.rank_id).name
      @schedules = Schedule.where(student: name)
    end
    @schedules = @schedules.paginate(page: params[:page], per_page: 12)
    #download
    @sch = Schedule.all
    respond_to do |format|
      format.xlsx { response.headers['Content-Disposition'] = "attachment; filename=beosztas.xlsx" }
      format.html { render :show }
    end
  end

  def create
  end

  def delete
    Schedule.delete_all
    redirect_to schedule_path
  end

end