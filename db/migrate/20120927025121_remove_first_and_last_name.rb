class RemoveFirstAndLastName < ActiveRecord::Migration
  def change
    remove_column :profiles, :first_name
    remove_column :profiles, :last_name
  end
end
