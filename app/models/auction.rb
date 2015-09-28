class Auction < ActiveRecord::Base
  has_many :bids, :dependent => :delete_all
  belongs_to :user
  validates_presence_of :start, :end

  validates_datetime :end, :after => :start

  validates :title, presence: true,
            length: { minimum: 10 }
  validates :text, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :kwh, presence: true
  validates :mileage, presence: true
  validates :color, presence: true
  validates :brand, presence: true
  validates :minimum_price, presence: true

  mount_uploader :avatar, AvatarUploader

  def has_ended
    DateTime.now.to_datetime < self.end.to_datetime
  end

  def self.user
    User.find(@user_id)
  end
end
