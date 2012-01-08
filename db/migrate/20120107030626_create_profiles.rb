class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.text :bio
      t.string :twitter
      t.string :job_title
      t.string :party_affiliation

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
