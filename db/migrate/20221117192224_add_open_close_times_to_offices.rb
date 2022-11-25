class AddOpenCloseTimesToOffices < ActiveRecord::Migration[6.1]
  def change
    add_column :offices, :open_hour, :time
    add_column :offices, :close_hour, :time
  end
end
