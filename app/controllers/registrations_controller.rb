class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(sign_up_params)
    if @user.save
      if @user.rank == 'student'
        redirect_to controller: 'student', action: 'new', user_id: @user.id
      else
        redirect_to controller: 'instructor', action: 'new', user_id: @user.id
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
