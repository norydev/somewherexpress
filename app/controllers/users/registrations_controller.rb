# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController

  # POST /resource
  def create
    super do
      NotificationSetting.create!(user: resource, locale: params[:locale] || :fr)
      UserMailer.welcome(resource.id).deliver_later
    end
  end

  # DELETE /resource
  def destroy
    resource.soft_delete
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
  end

  protected

    # PUT /resource
    def update_resource(resource, params)
      params.permit(:email, :password, :current_password)
      if resource.provider == "facebook"
        resource.update_without_password(params)
      else
        super
      end
    end

end