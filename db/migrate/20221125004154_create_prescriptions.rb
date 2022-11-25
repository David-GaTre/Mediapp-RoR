class CreatePrescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :prescriptions do |t|
      t.text :body
      t.date :date
      t.references :meeting, null: true, index: true, foreign_key: true
      t.references :office, null: false,  index: true, foreign_key: true
      t.references :patient, null: false,  index: true, foreign_key: true
      t.timestamps
    end
  end
end
