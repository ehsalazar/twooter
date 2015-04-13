class Twoot < ActiveRecord::Base
  has_many :twoot_tags
  has_many :hashtags, through: :twoot_tags
end
