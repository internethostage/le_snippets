require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "new" do

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

  end

  describe "create" do

    context "with valid user attributes" do

      def valid_user
        post :create, params: { user: attributes_for(:user) }
      end

      it "adds a new user record to the database" do
        count_before = User.count
        valid_user
        count_after = User.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the home page" do
        valid_user
        expect(response).to redirect_to(root_path)
      end

      it "sets a flash message" do
        valid_user
        expect(flash[:notice]).to be
      end

      it "sets the session user_id with the created user id" do
        valid_user
        expect(session[:user_id]).to eq(User.last.id)
      end

    end

    context "with invalid user attributes" do

      def invalid_user
        post :create, params: { user: attributes_for(:user, first_name: nil) }
      end

      it "doesn't add the user record to the database" do
        count_before = User.count
        invalid_user
        count_after = User.count
        expect(count_after).to eq(count_before)
      end

      it "sets a flash message" do
        invalid_user
        expect(flash[:warning]).to be
      end

      it "renders the new template again" do
        invalid_user
        expect(response).to render_template(:new)
      end

    end

  end

end
