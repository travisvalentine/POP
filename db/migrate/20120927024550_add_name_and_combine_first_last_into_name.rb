class AddNameAndCombineFirstLastIntoName < ActiveRecord::Migration
  def change
    add_column :profiles, :name, :string

    Profile.reset_column_information

    Profile.all.each do |profile|
      profile.update_column :name, "#{profile.first_name} #{profile.last_name}"
    end
  end
end
