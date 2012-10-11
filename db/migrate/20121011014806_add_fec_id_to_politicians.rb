class AddFecIdToPoliticians < ActiveRecord::Migration
  def change
    add_column :politicians, :fec_id, :string

  end
end
