class Auction < ActiveRecord::Base
  has_many :bids
  validates_presence_of :start, :end

  validates_datetime :end, :after => :start

end
