# frozen_string_literal: true
ActiveAdmin.register Subscription do
  permit_params :user_id, :competition_id, :status

  index do
    selectable_column
    column :id
    column :name
    column :status
    column :phone_number
    column :whatsapp
    column :telegram
    column :signal
    actions
  end

  form do |f|
    f.inputs "Subscription" do
      f.input :user
      f.input :competition
      f.input :status, collection: ["pending", "accepted", "refused"]
    end

    f.inputs "Contact" do
      f.input :phone_number
      f.input :whatsapp
      f.input :telegram
      f.input :signal
    end

    f.actions
  end
end
