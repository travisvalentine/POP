class CreatePoliticians < ActiveRecord::Migration
  def up
    create_table :politicians do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :party
      t.string :twitter
    end
  end

  def down
    drop_table :politicians
  end
end
