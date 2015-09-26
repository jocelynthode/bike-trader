class Auction < ActiveRecord::Base
  has_many :bids
  belongs_to :user
  validates_presence_of :start, :end

  validates_datetime :end, :after => :start

  mount_uploader :avatar, AvatarUploader

  def self.user
    User.find(@user_id)
  end
end
