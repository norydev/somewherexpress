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

class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = policy_scope(User)
  end

  def show
    authorize @user
  end

  def edit
    authorize @user, :update?
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :picture, :girl, :use_gravatar)
    end
end
