class City < ActiveRecord::Base
  belongs_to :localizable, polymorphic: true
end
