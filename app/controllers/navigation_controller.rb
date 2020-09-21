class NavigationController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :schedule]

  def home
  end

  def profile
    if current_user.is_instructor?
      redirect_to instructor_profile_path
    else
      redirect_to student_profile_path
    end
  end

  def schedule
    if current_user.is_instructor?
      redirect_to instructor_schedule_path
    else
      redirect_to student_schedule_path
    end
  end

  def confirm
  end
  
end
