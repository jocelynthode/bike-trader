class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates :amount, presence: true, :numericality => { :greater_than => 0 },
            :format => { :with => /\A\d+\.?\d{0,2}\z/ }
  validates :threshold, allow_blank: true, :numericality => { :greater_than => :amount },
            :format => { :with => /\A\d+\.?\d{0,2}\z/ }
end
