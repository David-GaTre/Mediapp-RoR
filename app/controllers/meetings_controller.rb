class MeetingsController < ApplicationController
  before_action :set_meeting, only: %i[ show edit update destroy ]

  # GET /meetings or /meetings.json
  def index
    @meetings = Meeting.all
  end

  # GET /meetings/1 or /meetings/1.json
  def show
  end

  def show_my_meetings 
    all_meetings = current_user.patient.meetings
    @today_meetings = all_meetings.where('extract(year from start_time) = ? AND extract(month from start_time) = ?  AND extract(day from start_time) = ?', Date.today.year, Date.today.month, Date.today.day)
    @previous_meetings = all_meetings - @today_meetings 

  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings or /meetings.json
  def create
    
    @meeting = Meeting.new(meeting_params)

    st = Time.utc(params["start_time(1i)"].to_i,params["start_time(2i)"].to_i, params["start_time(3i)"].to_i, params["start_time(4i)"].to_i+6,  params["start_time(5i)"].to_i, 0).in_time_zone 
    doctor_meetings = Meeting.all.where(doctor_id: params[:doctor_id], start_time: st)

    if doctor_meetings.count > 0 
      redirect_to root_path, notice: "Horario no disponible" and return
    end
    
    respond_to do |format|
      if @meeting.save
        
        @user = Patient.find(params[:patient_id]).user
        @doctor = Doctor.find(params[:doctor_id])
        
        
        UserMailer.with(user: @user, doctor: @doctor, meeting: @meeting).welcome_email.deliver_now
        format.html { redirect_to root_path, notice: "Cita agendada correctamente." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to show_my_meetings_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.permit(:name, :start_time, :doctor_id, :patient_id)
    end
end





