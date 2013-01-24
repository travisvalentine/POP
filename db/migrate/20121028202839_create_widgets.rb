class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.integer :politician_id
      t.string  :size
      t.timestamps
    end
  end
end
