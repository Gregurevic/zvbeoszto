class ApplicationController < ActionController::Base
  private

  def admin_access
    unless current_user.is_admin?
      redirect_to root_url
      flash[:alert] = 'You do not have access to this content!'
    end
  end

  #form select operations

  def instructors_to_list
    users = User.where(rank: 'instructor').pluck(:rank_id, :email)
    instructors = Instructor.pluck(:id, :name)
    @instructors = []
    for i in 0..(instructors.length - 1)
      @instructors << [ instructors[i][1].to_s, users.detect{|u| u[0] == instructors[i][0]}[1].to_s ]
    end
    @instructors.map{ |i| i[0].to_s+' ('+i[1].to_s+')' }
  end

  def courses_to_list
    @courses = Course.pluck(:name, :neptun)
    @courses.map{ |c| c[0].to_s+' ('+c[1].to_s+')' }
  end

  def instructor_id_from_list(instructors_list_element)
    Instructor.where(name: instructors_list_element[/(.*)\s/,1]).pluck(:id)[0]
  end

  def course_id_from_list(courses_list_element)
    Course.where(neptun: courses_list_element.split.last[1..11]).pluck(:id)[0]
  end
end
