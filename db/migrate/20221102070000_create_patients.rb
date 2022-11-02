class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :weight,         null: true, default: ""           
      t.string :height,         null: true, default: ""   
      t.string :blood_type,     null: true, default: ""   
      t.timestamps
    end
  end
end
