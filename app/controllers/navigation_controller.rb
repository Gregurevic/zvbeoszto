class NavigationController < ApplicationController
  before_action :authenticate_user!, only: [:profile, :schedule]

  def home
  end
  
end
