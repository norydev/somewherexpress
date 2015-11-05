class Track < ActiveRecord::Base
  belongs_to :competition
  has_many :ranks
end
