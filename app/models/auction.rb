class Auction < ActiveRecord::Base
  validates_presence_of :start, :end

  validates_datetime :end, :after => :start

  mount_uploader :avatar, AvatarUploader
end
