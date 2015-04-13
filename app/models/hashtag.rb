class Hashtag < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :twoot_tags
  has_many :twoots, through: :twoot_tags
end
