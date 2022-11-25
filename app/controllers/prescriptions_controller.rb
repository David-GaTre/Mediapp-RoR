class PrescriptionsController < ApplicationController
  before_action :set_prescription, only: %i[ show edit update destroy ]

  # GET /prescriptions or /prescriptions.json
  def index
    @prescriptions = Prescription.all.order('created_at DESC')
  end

  # GET /prescriptions/1 or /prescriptions/1.json
  def show
  end
  
  def download_prescription   
        
    prescription = Prescription.find(params[:prescription_id])
    office = prescription.office

    
    respond_to do |format|
      format.pdf do
        pdf = Prawn::Document.new(:page_size => 'A5', :page_layout => :landscape)
        pdf.font "Courier"
        pdf.text "<b>Fecha:</b> #{prescription.date}", :align => :right, :inline_format => true
        pdf.text "<b>#{office.name}</b>", :inline_format => true
        pdf.text office.address
        pdf.move_down 20
        pdf.text "<b>Paciente: </b>" +  prescription.patient.full_name, :inline_format => true
        pdf.text "<b>Indicaciones</b>", :inline_format => true
        pdf.text prescription.body
        pdf.move_down 10
        pdf.move_down 30
        pdf.text '_____________________', :align => :center
        pdf.move_down 5
        pdf.text "Dr." + office.doctor.full_name, :align => :center
        pdf.move_down 5
        pdf.text "Cédula: " + office.doctor.cedula, :align => :center
        send_data pdf.render,
          filename: "export.pdf",
          type: 'application/pdf',
          disposition: 'inline'
      end
    end
  end 

  # GET /prescriptions/new
  def new  
    @patients = Office.find(params[:office]).patients
    @prescription = Prescription.new(office_id: params[:office])
  end

  # GET /prescriptions/1/edit
  def edit
  end

  # POST /prescriptions or /prescriptions.json
  def create
    @prescription = Prescription.new(prescription_params)
    @prescription.date = DateTime.now  
    respond_to do |format|
      if @prescription.save
        format.html { redirect_to prescriptions_url, notice: "Prescription was successfully created." }
        format.json { render :show, status: :created, location: @prescription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prescriptions/1 or /prescriptions/1.json
  def update
    respond_to do |format|
      if @prescription.update(prescription_params)
        format.html { redirect_to prescription_url(@prescription), notice: "Prescription was successfully updated." }
        format.json { render :show, status: :ok, location: @prescription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @prescription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prescriptions/1 or /prescriptions/1.json
  def destroy
    @prescription.destroy

    respond_to do |format|
      format.html { redirect_to prescriptions_url, notice: "Prescription was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prescription
      @prescription = Prescription.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prescription_params
      params.require(:prescription).permit(:office_id, :patient_id, :meeting_id, :body)
    end
end
