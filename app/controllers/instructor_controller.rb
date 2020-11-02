class InstructorController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :update, :destroy]
  before_action :admin_or_rid?, only: [:profile, :update, :destroy]
  before_action :construct_courses_and_presence, only: [:create, :update]
  
  def new
    @courses = courses_to_list
    @temp = params[:user_id]
    @instructor = Instructor.new
  end

  def create
    courses = instructor_params[:course_list].split(" ")
    @instructor = Instructor.new(instructor_params.permit(:name, :can_be_president, :can_be_secretary, :can_be_member))
    if @instructor.save
      instructor_id = Instructor.where(name: @instructor[:name]).pluck(:id)[0]
      User.find(params[:user_id]).update(rank_id: instructor_id)
      courses.each do |c|
        Examiner.create(course_id: Course.where(neptun: c).pluck(:id)[0], instructor_id: instructor_id)
      end
      redirect_to root_path
      flash[:success] = 'Sikeres oktatói regisztráció!'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Az oktatói regisztráció sikertelen!'
    end
  end

  def destroy
    Instructor.find(params[:id]).safe_delete
    redirect_to applicants_path
  end

  def profile
    @instructor = Instructor.find(params[:id])
    @courses = courses_to_list
    @my_courses = Course.where(id: Examiner.where(instructor_id: @instructor.id).pluck(:course_id)).pluck(:name)
    #present_hours
    s_c = Student.count
    @present_hours = @instructor.presence
    if @present_hours.nil?
      @present_hours = []
      for i in 0..(s_c - 1)
        @present_hours << " "
      end
    elsif @present_hours.length <= (s_c - 1)
      @present_hours = @present_hours.split('')
      for i in @present_hours.count..(s_c - 1)
        @present_hours << " "
      end
    else
      @present_hours = @present_hours.split('')[0..(s_c - 1)]
    end
  end

  def update
    courses = instructor_params[:course_list].split(" ")
    instructor_id = params[:id]
    @instructor = Instructor.find(instructor_id)
    if @instructor.update(name:              instructor_params[:name],
                          can_be_president:  instructor_params[:can_be_president],
                          can_be_secretary:  instructor_params[:can_be_secretary],
                          can_be_member:     instructor_params[:can_be_member],
                          presence:          instructor_params[:present_hours])
      if courses.present?
        Examiner.delete(Examiner.where(instructor_id: instructor_id).pluck(:id))
        courses.each do |c|
          Examiner.create(course_id: Course.where(neptun: c).pluck(:id)[0], instructor_id: instructor_id)
        end
      end
      redirect_to current_user.is_admin? ? applicants_path : edit_instructor_path(id: params[:id])
      flash[:alert] = 'A hallgató adatmódosítása sikeres.'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A hallgató adatmódosítása sikertelen!'
    end
  end

  private

  def instructor_params
    params.require(:instructor).permit(:name, :can_be_president, :can_be_secretary, :can_be_member, :course_list, :present_hours)
  end

  def construct_courses_and_presence
    #courses
    if params[:instructor][:course_list].present?
      params[:instructor][:course_list].shift
      temp = []
      params[:instructor][:course_list].each do |c|
        temp << c.split.last[1..11] + " "
      end
      params[:instructor][:course_list] = temp.join
    else
      params[:instructor][:course_list] = ""
    end
    #presence
    if params[:instructor][:present_hours].present?
      temp = ""
      for i in 0..(Student.count - 1)
        if params[:instructor][:present_hours].include? i.to_s
          temp += "x"
        else
          temp += " "
        end
      end
      params[:instructor][:present_hours] = temp
    end
  end

  def admin_or_rid?
    unless current_user.is_admin? || current_user.rank_id.to_s == params[:id]
      redirect_to root_url
      flash[:alert] = 'You do not have access to this content!'
    end
  end

end
