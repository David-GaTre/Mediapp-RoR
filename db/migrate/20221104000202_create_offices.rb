class CreateOffices < ActiveRecord::Migration[6.1]
  def change
    create_table :offices do |t|
      t.string :name,                 null: false, default: ""           
      t.string :phone_number,         null: true, default: ""   
      t.string :address,              null: true, default: ""   
      t.timestamps
    end
  end
end
