require 'rails_helper'

RSpec.describe LanguagesController, type: :controller do

  describe "GET #index" do

    it "assigns an instance variable to all the languages in the DB" do
      l = create(:language, name: "Ruby")
      l2 = create(:language, name: "Python")
      get :index
      expect(assigns(:languages)).to eq([l, l2])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

  end

  describe "GET #show" do

    let(:language) { create(:language) }
    before {get :show, params: {id: language.id} }

    it "assigns the requested language to @language" do
      expect(assigns(:language)).to eq(language)
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    # TODO it "assigns @snippets to the list of snippets of the requested language"

  end

end
