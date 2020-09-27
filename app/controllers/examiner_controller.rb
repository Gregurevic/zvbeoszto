class ExaminerController < ApplicationController
  require 'will_paginate/array'

  def index
    #examiners
    users = User.where(rank: 'instructor').pluck(:rank_id, :email)
    @examiners = Examiner.pluck(:id, :course_id, :instructor_id)
    @examiners.each do |e|
      e1 = Course.find(e[1])
      e[1] = e1.name.to_s + " (" + e1.neptun.to_s + ")"
      e[2] = Instructor.find(e[2]).name.to_s + " (" + users.detect{|u| u[0] == e[2]}[1].to_s + ")"
    end
    @examiners = @examiners.sort_by{|e| e[1]}
    for i in 0..(@examiners.length-1)
      @examiners[i] << (i+1)
    end
    @examiners = @examiners.paginate(page: params[:examiner_page], per_page: 12)
    #examiner
    instructors = Instructor.pluck(:id, :name)
    @instructors = []
    for i in 0..(instructors.length - 1)
      @instructors << [ instructors[i][1].to_s, users.detect{|u| u[0] == instructors[i][0]}[1].to_s ]
    end
    @courses = Course.pluck(:name, :neptun)
    @examiner = Examiner.new
  end

  def create
    course_id = Course.find_by(neptun: examiner_params[:course_id].split.last[1..11]).id
    instructor_id = Instructor.find_by(name: examiner_params[:instructor_id][/(.*)\s/,1]).id
    @examiner = Examiner.new(course_id: course_id, instructor_id: instructor_id)
    if(Examiner.where(course_id: course_id, instructor_id: instructor_id).empty?)
      if @examiner.save
        redirect_to examiners_list_path
        flash[:success] = 'Sikeres vizsgáztatói regisztráció!'
      else
        redirect_to examiners_list_path
        flash[:alert] = 'A vizsgáztatói regisztráció sikertelen!'
      end
    else
      redirect_to examiners_list_path
      flash[:warning] = 'Ez a vizsgáztatói kapcsolat már létezik.'
    end
  end

  def destroy
    Examiner.find(params[:id]).destroy
    redirect_to examiners_list_path
  end

  private

  def examiner_params
    params.require(:examiner).permit(:course_id, :instructor_id)
  end
end