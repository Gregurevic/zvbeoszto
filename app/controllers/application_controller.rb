class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:home]

  def home
  end

  def profile
  end

  def schedule
  end
  
end
