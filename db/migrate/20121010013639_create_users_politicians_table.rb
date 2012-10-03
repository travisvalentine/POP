class CreateUsersPoliticiansTable < ActiveRecord::Migration
  def up
    create_table :users_politicians, :id => false do |t|
      t.references :user, :null => false
      t.references :politician, :null => false
    end
  end

  def down
    drop_table :users_politicians
  end
end
