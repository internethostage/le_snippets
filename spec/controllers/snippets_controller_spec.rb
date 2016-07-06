require 'rails_helper'

RSpec.describe SnippetsController, type: :controller do

  describe 'GET #index' do

    it "assigns an instance variable to all the snippets in the DB" do
      s = create(:snippet, name: "Test1")
      s2 = create(:snippet, name: "Test2")
      get :index
      expect(assigns(:snippets)).to eq([s,s2])
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template(:index)
    end

  end

  describe 'GET #show' do

    let(:snippet) { create(:snippet) }
    before {get :show, params: {id: snippet.id} }

    it "assigns the requested snippet to @snippet" do
      expect(assigns(:snippet)).to eq(snippet)
    end

    it "renders the :show template" do
      expect(response).to render_template(:show)
    end

  end

  describe 'GET #new' do

    before {get :new}

    it "assigns a new Snippet to @snippet" do
      expect(assigns(:snippet)).to be_a_new(Snippet)
    end

    it "renders the :new template" do
      expect(response).to render_template(:new)
    end

  end

  describe 'GET #edit' do

    let(:snippet) { create(:snippet) }
    before {get :edit, params: {id: snippet.id} }

    it "assigns the requested snippet to @snippet" do
      expect(assigns(:snippet)).to eq(snippet)
    end

    it "renders the :edit template" do
      expect(response).to render_template(:edit)
    end

  end

  #TODO describe 'POST #create' do
  #
  #   context "with valid attributes" do
  #
  #     it "saves the new snippet in the database"
  #     it "redirects to snippet#show"
  #
  #   end
  #
  #   context "with invalid attributes" do
  #     it "does not save the new snippet in the database"
  #     it "re renders the :new template"
  #   end
  # end

  describe 'PATCH #update' do

    before :each do
      @snippet = create(:snippet, name: "getElementById")
    end

    context "with valid attributes" do

      it "located the requested @snippet" do
        patch :update, params: { id: @snippet, snippet: attributes_for(:snippet) }
        expect(assigns(:snippet)).to eq(@snippet)
      end

      it "updates the snippet in the database" do
        patch :update, params: { id: @snippet, snippet: attributes_for(:snippet, name: ".ready()") }
        @snippet.reload
        expect(@snippet.name).to eq(".ready()")
      end

      it "redirects to the updated snippet" do
        patch :update, params: { id: @snippet, snippet: attributes_for(:snippet) }
        expect(response).to redirect_to @snippet
      end

    end

    context "with invalid attributes" do

      before {patch :update, params: { id: @snippet, snippet: attributes_for(:snippet, name: nil) } }

      it "does not update the snippet" do
        @snippet.reload
        expect(@snippet.name).to eq("getElementById")
      end

      it "re renders the #edit template" do
        expect(response).to render_template :edit
      end

    end

  end

  describe 'DELETE #destroy' do

    before :each do
      @snippet = create(:snippet)
    end

    it "deletes the snippet from the database" do
      expect{
        delete :destroy, params: { id: @snippet }
      }.to change(Snippet, :count).by(-1)
    end

    it "redirects to the snippets#index" do
      delete :destroy, params: { id: @snippet }
      expect(response).to redirect_to snippets_url
    end

  end

end
