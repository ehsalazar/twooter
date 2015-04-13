class Twoot < ActiveRecord::Base
  has_many :twoots_tags
  has_many :hashtags, through: :twoots_tags
end
