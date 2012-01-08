class CreateSolutions < ActiveRecord::Migration
  def self.up
    create_table :solutions do |t|
      t.text :body
      t.datetime :published_at
      t.integer :user_id
      t.string :tag_tokens
      
      t.timestamps
    end
  end

  def self.down
    drop_table :solutions
  end
end
