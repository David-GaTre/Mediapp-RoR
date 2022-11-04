class DashboardsController < ApplicationController
  
  def index
    if current_user
      if current_user.role == "doctor"
        respond_to do |format|
          format.html { render :template => "dashboards/doctor", :locals => { :user => @current_user } }
        end
      elsif current_user.role == 'patient'
        respond_to do |format|
          format.html { render :template => "dashboards/patient", :locals => { :user => @current_user } }
        end
      end
    else
      redirect_to new_user_session_url
    end
  end


end
