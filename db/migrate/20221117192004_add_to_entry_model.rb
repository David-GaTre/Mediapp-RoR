class AddToEntryModel < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :weight, :float, :null => true
    add_column :entries, :height, :float, :null => true
    add_column :entries, :bloodPressureSys, :int, :null => true
    add_column :entries, :bloodPressureDia, :int, :null => true
  end
end
