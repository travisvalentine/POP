class AddSolutionIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :solution_id, :integer
  end
end
