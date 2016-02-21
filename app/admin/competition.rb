ActiveAdmin.register Competition do

  permit_params :name, :start_date, :end_date, :finished, :published,
    :start_registration, :end_registration, :author_id, :description,
    :default_registration_status, :video

  index do
    selectable_column
    column :id
    column :name
    column :start_date
    column :end_date
    column :finished
    column :published
    column :start_registration
    column :end_registration
    column :author
    actions
  end

  form do |f|
    f.inputs "Competition" do
      f.input :name
      f.input :start_date
      f.input :end_date
      f.input :author
      f.input :description
      f.input :finished
      f.input :video
    end

    f.has_many :tracks do |item|
      item.input :start_time
      # item.input :start_city, collection: City.all
      # item.input :end_city, collection: City.all
    end

    f.inputs "Registrations" do
      f.input :default_registration_status
      f.input :start_registration
      f.input :end_registration
      f.input :published
    end

    f.actions
  end

end