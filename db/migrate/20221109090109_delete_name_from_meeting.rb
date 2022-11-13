class DeleteNameFromMeeting < ActiveRecord::Migration[6.1]
  def change
    remove_column :meetings, :name
  end
end
