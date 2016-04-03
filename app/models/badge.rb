# == Schema Information
#
# Table name: badges
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  picture     :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Badge < ActiveRecord::Base
  belongs_to :user
end
