class CreateIssueProblems < ActiveRecord::Migration
  def self.up
    create_table :issue_problems do |t|
      t.integer :problem_id
      t.integer :issue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :issue_problems
  end
end
