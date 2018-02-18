# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  picture                :string
#  admin                  :boolean          default(FALSE), not null
#  organizer              :boolean          default(FALSE), not null
#  girl                   :boolean          default(FALSE), not null
#  deleted_at             :datetime
#  old_first_name         :string
#  old_last_name          :string
#  old_email              :string
#  provider               :string
#  uid                    :string
#  token                  :string
#  token_expiry           :datetime
#  use_gravatar           :boolean          default(FALSE), not null
#  phone_number           :string
#  whatsapp               :boolean          default(FALSE), not null
#  telegram               :boolean          default(FALSE), not null
#  signal                 :boolean          default(FALSE), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

FactoryBot.define do
  factory :user do
    email       { Faker::Internet.email }
    password    "12345678"
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    picture     "https://unsplash.it/200/200"
    girl        false
    organizer   true
    admin       false
  end
end
