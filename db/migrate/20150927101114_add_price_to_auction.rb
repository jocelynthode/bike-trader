class AddPriceToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :minimum_price, :integer
  end
end
