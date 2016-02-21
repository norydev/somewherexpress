ActiveAdmin.register Rank do

  permit_params :user_id, :result, :points, :race_id, :race_type, :dsq

  index do
    selectable_column
    column :id
    column :user
    column :result
    column :points
    column :race
    column :dsq
    actions
  end

  form do |f|
    f.inputs "Rank" do
      f.input :user
      f.input :result
      f.input :points
      f.input :dsq
      f.input :race, collection: (Track.all + Competition.all)
    end

    f.actions
  end

end