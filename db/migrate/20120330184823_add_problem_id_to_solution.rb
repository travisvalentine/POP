class AddProblemIdToSolution < ActiveRecord::Migration
  def self.up
    add_column :solutions, :problem_id, :integer
  end

  def self.down
    remove_column :solutions, :problem_id
  end
end
