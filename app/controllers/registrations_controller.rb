class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    if @user.save
      if @user.rank == 'student'
        @user.id = params[:temp]
        redirect_to student_registration(user_id: params[:temp])
      else
        redirect_to instructor_registration(user_id: params[:temp])
      end
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'A regisztráció sikertelen!'
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :rank)
  end

end
