class ExaminerController < ApplicationController
  def new
    @instructors = instructors_to_list
    @courses = courses_to_list
    @examiner = Examiner.new
  end

  def create
    course_id = Course.find_by(neptun: examiner_params[:course_id].split.last[1..11]).id
    instructor_id = Instructor.find_by(name: examiner_params[:instructor_id][/(.*)\s/,1]).id
    @examiner = Examiner.new(course_id: course_id, instructor_id: instructor_id)
    if(Examiner.where(course_id: course_id, instructor_id: instructor_id).empty?)
      if @examiner.save
        redirect_to applicants_path
        flash[:success] = 'Sikeres vizsgáztatói regisztráció!'
      else
        redirect_to new_examiner_path
        flash[:alert] = 'A vizsgáztatói regisztráció sikertelen!'
      end
    else
      redirect_to new_examiner_path
      flash[:warning] = 'Ez a vizsgáztatói kapcsolat már létezik.'
    end
  end

  def destroy
    Examiner.find(params[:id]).destroy
    redirect_to applicants_path
  end

  private

  def examiner_params
    params.require(:examiner).permit(:course_id, :instructor_id)
  end
end