class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_access
  require 'will_paginate/array'
	
  def applicants
    #courses
    @courses = Course.pluck(:id, :name, :neptun)
    for i in 1..@courses.length
      @courses[i-1] << i
    end
    @courses = @courses.paginate(page: params[:course_page], per_page: 4)
    #instructors
    @instructors = Instructor.pluck(:id, :name, :can_be_president, :can_be_secretary, :can_be_member)
    for i in 1..@instructors.length
      @instructors[i-1] << i
    end
    @instructors = @instructors.paginate(page: params[:instructor_page], per_page: 4)
    #students
    @students = Student.pluck(:id, :name, :neptun, :course_id, :instructor_id)
    for i in 0..(@students.length-1)
      @students[i][3] = Course.find(@students[i][3]).name
      @students[i][4] = Instructor.find(@students[i][4]).name
      @students[i] << (i+1)
    end
    @students = @students.paginate(page: params[:student_page], per_page: 10)
  end

  def current_schedule
  end

  def course_registration
  end  
end
