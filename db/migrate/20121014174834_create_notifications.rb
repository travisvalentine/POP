class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text    :body
      t.string  :notification_type
      t.integer :problem_id
      t.integer :user_id
      t.integer :related_object_id
      t.boolean :read, :default => false

      t.timestamps
    end
  end
end
