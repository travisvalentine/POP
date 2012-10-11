class CreatePoliticianUsers < ActiveRecord::Migration
  def change
    create_table :politician_users do |t|
      t.integer :politician_id
      t.integer :user_id
      t.timestamps
    end
  end
end
