ActiveAdmin.register Subscription do

  permit_params :user_id, :competition_id, :status

  index do
    selectable_column
    column :id
    column :name
    column :status
    actions
  end

  form do |f|
    f.inputs "Subscription" do
      f.input :user
      f.input :competition
      f.input :status, collection: ["pending", "accepted", "refused"]
    end

    f.actions
  end

end