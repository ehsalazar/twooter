class Hashtag < ActiveRecord::Base
  validates :name, uniqueness: true
  has_many :twoots_tags
  has_many :twoots, through: :twoots_tags
end
