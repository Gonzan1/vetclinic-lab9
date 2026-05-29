class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]

  def index
    @appointments = policy_scope(Appointment).includes(:pet, :vet)
  end

  def show
    @appointment = Appointment.find(params[:id])
    @treatments = @appointment.treatments.with_rich_text_clinical_notes
  end

  def new
    @appointment = Appointment.new(status: 'scheduled')
    authorize @appointment
  end

  def create
    @appointment = Appointment.new(appointment_params)
    authorize @appointment
    if @appointment.save
      redirect_to @appointment, notice: 'Appointment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to @appointment, notice: 'Appointment was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @appointment.destroy
    redirect_to appointments_path, notice: 'Appointment was successfully deleted.'
  end

  private

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
    params.require(:appointment).permit(:date, :reason, :status, :pet_id, :vet_id)
  end
end