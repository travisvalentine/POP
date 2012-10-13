class AddShortTitleToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :short_title, :string

  end
end
