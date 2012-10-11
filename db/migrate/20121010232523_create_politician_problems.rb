class CreatePoliticianProblems < ActiveRecord::Migration
  def change
    create_table :politician_problems do |t|
      t.integer :politician_id
      t.integer :problem_id
      t.timestamps
    end
  end
end
