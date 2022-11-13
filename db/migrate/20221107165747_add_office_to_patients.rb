class AddOfficeToPatients < ActiveRecord::Migration[6.1]
  def change
    create_join_table :patients, :offices
  end
end
