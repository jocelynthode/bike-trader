class AddImage < ActiveRecord::Migration
  def change
    add_column :auctions, :avatar, :string
  end
end
