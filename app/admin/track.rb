# frozen_string_literal: true
ActiveAdmin.register Track do
  permit_params :competition_id, :start_time

  index do
    selectable_column
    column :id
    column :competition
    column :start_city
    column :end_city
    column :start_time
    actions
  end

  form do |f|
    f.inputs "Track" do
      f.input :competition
      # f.input :start_city
      # f.input :end_city
      f.input :start_time
    end

    f.actions
  end
end
