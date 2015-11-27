RailsAdmin.config do |config|

  config.authorize_with do |controller|
    redirect_to main_app.root_path unless current_user.admin
  end

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'User' do
    list do
      field :id
      field :first_name
      field :last_name
      field :email do
        formatted_value do
          bindings[:view].tag(:img, { src: "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest bindings[:object].email}?s=60", height: "30px", width: "30px" }) << value
        end
      end
      field :girl
      field :admin
      field :organizer
      field :reset_password_token
      field :reset_password_sent_at
      field :remember_created_at
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :created_at
      field :updated_at
      field :deleted_at
      field :old_first_name
      field :old_last_name
      field :old_email
    end
  end

end
