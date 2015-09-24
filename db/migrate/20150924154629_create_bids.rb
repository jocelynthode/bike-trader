class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user, index: true, foreign_key: true
      t.references :auction, index: true, foreign_key: true
      t.integer :amount
      t.datetime :time
      t.integer :threshold

      t.timestamps null: false
    end
  end
end
