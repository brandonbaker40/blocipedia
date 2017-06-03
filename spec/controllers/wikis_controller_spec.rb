require 'rails_helper'


RSpec.describe WikisController, type: :controller do

  let(:valid_attributes) {
    { title: 'MyTitle',
      body: 'MyBody',
      private: false }
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  let(:valid_session) { {} }

  before do
    @user = User.create!(email: 'standard@bloc.io', password: 'standard1234', role: 0)
    sign_in @user
    @wiki  = Wiki.create!(title: 'title', body: 'body', private: false, user: @user)

    ####
    @premium_user = User.create!(email: 'premium@bloc.io', password: 'premium 1234', role: 1)
    sign_in @premium_user
    @premium_wiki = Wiki.create!(title: 'premium title', body: 'premium body', private: true, user: @premium_user)

    @admin_user = User.create!(email: 'admin@bloc.io', password: 'admin 1234', role: 2)
    sign_in @admin_user
    @admin_wiki = Wiki.create!(title: 'admin title', body: 'admin body', private: false, user: @admin_user)
    ###

  end

  describe "GET #index" do
    it "returns http success" do
      sign_in @user
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns [my_wiki] to @wiki" do
        sign_in @user
        get :index
        expect(assigns(@wiki)).to eq(@wikis)
    end
  end

  describe "GET #show" do
    it "assigns the requested wiki as @wiki" do
      expect(assigns(@wiki)).to eq(@wikis)
    end
  end

  describe "GET #new" do
    it "assigns a new wiki as @wiki" do
      get :new, params: {}, session: valid_session
      expect(assigns(:wiki)).to be_a_new(Wiki)
    end
  end

  describe "GET #edit" do
    it "assigns the requested wiki as @wiki" do
      get :edit, id: @wiki.id
      expect(assigns(@wiki)).to eq(@wikis)
    end
  end

  describe "PUT update" do
    let(:new_attributes) { FactoryGirl.attributes_for(:wiki, title: 'New Title', body: 'New Body', private: false) }

    it "updates the requested wiki" do
      wiki = @user.wikis.create! valid_attributes
      sign_in @user
      put :update, {:id => wiki.to_param, :wiki => new_attributes}, valid_session
      wiki.reload
      expect(assigns(:wiki).attributes['title']).to match(new_attributes[:title])
      expect(response).to redirect_to(wiki_path)
    end
  end

  describe "POST create a new wiki" do
    it "successfully creates a new wiki" do
      wiki_params = FactoryGirl.attributes_for(:wiki)
      expect { post :create, :wiki => wiki_params }.to change(Wiki, :count).by(1)
    end
    it "adds @wiki to end of @wikis" do
      expect(@wiki).to eq(Wiki.first)
    end

    #### probably unneccessary
    it "adds @premium_wiki to end of @wikis" do
      expect(@premium_wiki).to eq(Wiki.second)
    end
    it "adds @admin_wiki to end of @wikis" do
      expect(@admin_wiki).to eq(Wiki.last)
    end
    #### probably unneccessary ^^^^^

    it "should be a public wiki" do
      expect(@wiki.private).to eq(false)
    end

    ##### probably unneccessary
    it "should be a public wiki" do
      expect(@premium_wiki.private).to eq(true)
    end
    ###### probably unneccessary ^^^^
  end

  describe "GET #show" do
    it "assigns the requested wiki as @wiki" do
      get :show, id: @wiki.id
      expect(assigns(@wiki)).to eq(@wikis)
    end
  end

  describe "DELETE #destroy wiki user owns" do
    it "should delete the wiki" do
      expect { delete :destroy, id: @wiki.id }.to change(Wiki, :count).by(-1)
      expect(response).to redirect_to(wikis_url)
    end

    it "should NOT delete the wiki" do
      ##### this is failing, could be something wrong in my controller
      expect { delete :destroy, id: @premium_wiki.id }.to_not change(Wiki, :count)
      expect(flash[:alert]).to_not be_nil
    end
  end
end
