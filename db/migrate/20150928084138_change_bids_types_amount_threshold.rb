class ChangeBidsTypesAmountThreshold < ActiveRecord::Migration
  def change
    change_column :bids, :amount, :decimal, precision: 6, scale: 2
    change_column :bids, :threshold, :decimal, precision: 6, scale: 2
  end
end
