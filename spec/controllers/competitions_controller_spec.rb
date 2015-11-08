require 'rails_helper'

RSpec.describe CompetitionsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Period. As you add validations to Period, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for(:competition) }

  let(:invalid_attributes) { { start_date: 4, end_date: "hello" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PeriodsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let(:competitions) { Competition.all }

  before(:context) do
    @user = FactoryGirl.create :user
  end

  describe "GET #new" do
    it "assigns a new competition as @competition" do
      sign_in @user
      get :new, {}, valid_session
      expect(assigns(:competition)).to be_a_new(Competition)
    end
  end

  describe "GET #edit" do
    it "assigns the requested competition as @competition" do
      sign_in @user
      competition = FactoryGirl.create :competition
      get :edit, { id: competition.to_param }, valid_session
      expect(assigns(:competition)).to eq(competition)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Competition" do
        sign_in @user
        expect { post :create, { competition: valid_attributes }, valid_session }.to change(Competition, :count).by(1)
      end

      it "assigns a newly created competition as @competition" do
        sign_in @user
        post :create, { competition: valid_attributes }, valid_session
        expect(assigns(:competition)).to be_a(Competition)
        expect(assigns(:competition)).to be_persisted
      end

      it "redirects to the created competition" do
        sign_in @user
        post :create, { competition: valid_attributes }, valid_session
        expect(response).to redirect_to(competition_path(competition))
      end
    end

    # context "with invalid params" do
    #   it "assigns a newly created but unsaved period as @period" do
    #     post :create, { period: invalid_attributes }, valid_session
    #     expect(assigns(:period)).to be_a_new(Period)
    #   end

    #   it "re-renders the 'new' template" do
    #     post :create, { period: invalid_attributes }, valid_session
    #     expect(response).to render_template("new")
    #   end
    # end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { start_location: "Bâle" } }

      it "updates the requested competition" do
        sign_in @user
        competition = FactoryGirl.create :competition
        put :update, { id: competition.to_param, competition: new_attributes }, valid_session
        competition.reload
        expect(assigns(:competition)).to have_attributes(start_location: "Bâle")
      end

      it "assigns the requested competition as @competition" do
        sign_in @user
        competition = FactoryGirl.create :competition
        put :update, { id: competition.to_param, competition: valid_attributes }, valid_session
        expect(assigns(:competition)).to eq(competition)
      end

      it "redirects to the competition" do
        sign_in @user
        competition = FactoryGirl.create :competition
        put :update, { id: competition.to_param, competition: valid_attributes }, valid_session
        expect(response).to redirect_to(competition_path(competition))
      end
    end

    # context "with invalid params" do
    #   it "assigns the period as @period" do
    #     sign_in @user
    #     period = FactoryGirl.create :period, destination: @destination
    #     put :update, { id: period.to_param, period: invalid_attributes }, valid_session
    #     expect(assigns(:period)).to eq(period)
    #   end

    #   it "re-renders the 'edit' template" do
    #     sign_in @user
    #     period = FactoryGirl.create :period, destination: @destination
    #     put :update, { id: period.to_param, period: invalid_attributes }, valid_session
    #     expect(response).to render_template("edit")
    #   end
    # end
  end

  # describe "DELETE #destroy" do
  #   it "destroys the requested period" do
  #     sign_in @user
  #     period = FactoryGirl.create :period, destination: @destination
  #     expect { delete :destroy, { id: period.to_param }, valid_session }.to change(Period, :count).by(-1)
  #   end

  #   it "redirects to the periods list" do
  #     sign_in @user
  #     period = FactoryGirl.create :period, destination: @destination
  #     delete :destroy, { id: period.to_param }, valid_session
  #     expect(response).to redirect_to(root_path)
  #   end
  # end
end
