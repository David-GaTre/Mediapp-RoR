class DashboardsController < ApplicationController
  
  def index
    if current_user
      if current_user.role == "doctor"
        @meetings = Meeting.all.where(doctor_id: current_user.doctor.id)
        @meetings_today = Meeting.all.where(start_time: DateTime.now.beginning_of_day..DateTime.now.end_of_day, doctor_id: current_user.doctor.id)
        respond_to do |format|
          format.html { render :template => "dashboards/doctor", :locals => { :user => @current_user, :meetings => @meetings } }
        end
      elsif current_user.role == 'patient'
        @meetings_today = Meeting.all.where(start_time: DateTime.now.beginning_of_day..DateTime.now.end_of_day, patient_id: current_user.patient.id)
        @offices = @current_user.patient.offices
        respond_to do |format|
          format.html { render :template => "dashboards/patient", :locals => { :user => @current_user, :offices => @offices } }
        end
      end
    else
      redirect_to new_user_session_url
    end
  end


end
