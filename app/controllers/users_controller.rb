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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  picture                :string
#  admin                  :boolean          default(FALSE), not null
#  organizer              :boolean          default(FALSE), not null
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
    @users = policy_scope(User).hall_of_fame
                               .preload(:competition_victories, :badges,
                                        track_victories: [:start_city, :end_city])
  end

  def show
    authorize @user

    @badge = @user.founder_badge
    @competition_victories = @user.competition_victories
    @track_victories = @user.track_victories.preload(:start_city, :end_city)
    @finished_competitions = @user.finished_competitions
                                  .order(start_date: :desc)
                                  .preload(:ranks, tracks: [:ranks, :start_city,
                                                            :end_city])
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
      params.require(:user).permit(:first_name, :last_name, :picture, :use_gravatar)
    end
end
