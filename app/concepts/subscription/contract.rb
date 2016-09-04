# frozen_string_literal: true
class Subscription < ActiveRecord::Base
  module Contract
    class Create < Reform::Form
      include ActiveModel::ModelReflections
      model :subscription

      properties :status, :rules
      properties :user_id, :competition_id

      property :user, populate_if_empty: :populate_user!,
                      prepopulator: :prepopulate_user! do
        properties :phone_number, :whatsapp, :telegram, :signal
      end

      validates :status, presence: true, inclusion: { in: ["pending", "accepted"] }

      validates :rules, acceptance: true, allow_nil: false
      validates :user_id, :competition_id, presence: true
      validates_uniqueness_of :user_id, scope: :competition_id,
                                        message: "You already applied to this competition"

      def populate_user!(options)
        User.find_by(id: options[:fragment][:id])
      end

      def prepopulate_user!(options)
        self.user = options[:user]
      end
    end

    class Update < Reform::Form
      include ActiveModel::ModelReflections
      model :subscription

      properties :status
      validates :status, presence: true,
                         inclusion: { in: ["pending", "accepted", "refused"] }
    end
  end
end
