class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    if @user.save
      params[:user_id] = User.find_by(email: @user.email).id
      if @user.rank == 'student'
        redirect_to student_registration_path(user_id: params[:user_id])
      else
        redirect_to instructor_registration_path(user_id: params[:user_id])
      end
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A regisztráció sikertelen!'
    end
  end

  def edit
    byebug
    @user = current_user.is_admin? ? User.find(params[:id]) : current_user
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :rank)
  end

end
