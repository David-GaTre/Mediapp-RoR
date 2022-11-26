class EntriesController < ApplicationController
  before_action :set_entry, only: %i[ show edit update destroy ]

  # GET /entries or /entries.json
  def index    
    @entries = Entry.all.where(office_id: params[:office]).order('created_at DESC')
  end

  def filtered_entries
    @all_entries = Entry.all.where(office_id: current_user.doctor.office.id).order('created_at DESC')
    @entries = @all_entries.where(date: params[:date_filter]) if params[:date_filter]
    patients = []
    if params[:patient_name] != ""
      current_user.doctor.office.patients.each do |patient|
        if patient.full_name == params[:patient_name]
          patients.append(patient.id)
        end
      end
      @entries = @all_entries.where(patient_id:  patients)
    end  
    
    if @entries.count == 0 
      @entries = @all_entries
    end
    respond_to do |format|
      format.html { render :template => "entries/index.html.erb", :locals => { :entries => @entries } }
    end
  end

  # GET /entries/1 or /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @patients = Office.find(params[:office]).patients
    @entry = Entry.new(office_id: params[:office])
  end

  # GET /entries/1/edit
  def edit
    office = Entry.find(params[:id]).office
    @patients = office.patients
  end

  # POST /entries or /entries.json
  def create
    @entry = Entry.new(entry_params)
    @entry.date = DateTime.now  
    @entry.office_id = current_user.doctor.office.id
    
    binding.pry
    
    respond_to do |format|
      if @entry.save
        format.html { redirect_to entries_path(office: @entry.office_id) }
        format.json { render :show, status: :created, location: @entry }
      else

        
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1 or /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to entries_path(office: current_user.doctor.office.id), notice: "Entry was successfully updated." }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1 or /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: "Entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def entry_params
      params.require(:entry).permit(:comments, :office_id, :patient_id, :entry_type, :weight, :height, :bloodPressureSys, :bloodPressureDia)
    end

end
