class ChangeAuctionsTypesKwhMileage < ActiveRecord::Migration
  def change
    change_column :auctions, :kwh, :decimal, precision: 6, scale: 3
    change_column :auctions, :mileage, :integer
  end
end
