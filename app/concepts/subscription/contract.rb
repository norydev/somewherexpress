# frozen_string_literal: true
class Subscription < ActiveRecord::Base
  module Contract
    class Create < Reform::Form
      include ActiveModel::ModelReflections
      model :subscription

      properties :status, :rules, :phone_number, :whatsapp, :telegram, :signal
      properties :user_id, :competition_id

      validates :status, presence: true, inclusion: { in: ["pending", "accepted"] }

      validates :rules, acceptance: true, allow_nil: false
      validates_uniqueness_of :user_id, scope: :competition_id,
                                        message: "You already applied to this competition"
      validates :user_id, :competition_id, presence: true
    end

    class Update < Reform::Form
      include ActiveModel::ModelReflections
      model :subscription

      properties :status
      validates :status, presence: true, inclusion: { in: ["pending", "accepted", "refused"] }
    end
  end
end
