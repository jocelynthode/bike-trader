class ChangeCamelCaseNaming < ActiveRecord::Migration
  def change
    rename_column :auctions, :timeToEnd, :time_to_end
    rename_column :auctions, :isFinished, :is_finished
  end
end
