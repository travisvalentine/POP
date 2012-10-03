class CreateProblemsPoliticiansTable < ActiveRecord::Migration
  def up
    create_table :problems_politicians, :id => false do |t|
      t.references :problem, :null => false
      t.references :politician, :null => false
    end
  end

  def down
    drop_table :problems_politicians
  end
end
