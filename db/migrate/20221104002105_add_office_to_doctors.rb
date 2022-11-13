class AddOfficeToDoctors < ActiveRecord::Migration[6.1]
  def change
    add_reference :doctors, :office, null: true, foreign_key: true
    add_reference :offices, :doctor, null: false, foreign_key: true
  end
end
