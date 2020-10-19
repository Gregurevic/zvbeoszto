class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only:[:edit, :update]
  before_action :admin_or_owner?, only:[:edit, :update]

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
    if params[:rank] == 'student'
      @user = User.where(rank: 'student', rank_id: params[:id])[0]
    elsif params[:rank] == 'instructor'
      @user = User.where(rank: 'instructor', rank_id: params[:id])[0]
    end
  end

  def update
    @user = User.find(params[:id])
    if update_resource(@user, sign_up_params)
      flash[:success] = 'Sikeres felhasználói adatmódosítás!'
      if current_user.is_instructor?
        redirect_to edit_instructor_path(id: @user.rank_id, rank: 'instructor')
      elsif current_user.is_admin?
        redirect_to applicants_path
      else
        redirect_to edit_student_path(id: @user.rank_id, rank: 'student')
      end
    else
      redirect_to edit_user_registration_path(id: params[:id], rank: params[:rank])
      flash[:alert] = 'Sikertelen felhasználói adatmódosítás!'
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :rank, :current_password)
  end

  def admin_or_owner?
    unless current_user.is_admin? || current_user.id == params[:id]
      redirect_to root_url
      flash[:alert] = 'You do not have access to this content!'
    end
  end

end
