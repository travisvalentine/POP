class AddActiveToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :active, :boolean, :default => true
  end
end
