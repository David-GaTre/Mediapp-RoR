class AddPatientDoctorToMeeting < ActiveRecord::Migration[6.1]
  def change
    add_reference :meetings, :doctor, null: false, foreign_key: true
    add_reference :meetings, :patient, null: false, foreign_key: true
  end
end
