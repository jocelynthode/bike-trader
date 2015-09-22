class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :text
      t.datetime :start
      t.datetime :end
      t.timestamp :timeToEnd
      t.boolean :isFinished
      t.string :kwh
      t.string :mileage
      t.string :color
      t.string :brand
      t.references :user

      t.timestamps null: false
    end
  end
end
