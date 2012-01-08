class CreateFactchecks < ActiveRecord::Migration
  def self.up
    create_table :factchecks do |t|
      t.text :body
      t.string :link
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :factchecks
  end
end
