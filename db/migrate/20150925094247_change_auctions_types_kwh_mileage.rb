class ChangeAuctionsTypesKwhMileage < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.adapter_name.downcase.start_with? 'postgresql'
      change_column :auctions, :kwh, 'decimal(6,3) USING CAST(kwh AS decimal)', precision: 6, scale: 3
      change_column :auctions, :mileage, 'integer USING CAST(mileage AS integer)'
    else
      change_column :auctions, :kwh, :decimal, precision: 6, scale: 3
      change_column :auctions, :mileage, :integer
    end
  end
end
