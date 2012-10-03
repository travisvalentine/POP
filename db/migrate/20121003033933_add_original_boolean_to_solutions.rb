class AddOriginalBooleanToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :original, :boolean, :default => false

  end
end
