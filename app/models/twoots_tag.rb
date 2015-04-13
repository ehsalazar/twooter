class TwootsTag < ActiveRecord::Base
  belongs_to :hashtag
  belongs_to :twoot
end
