require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:new_standard_user_attributes) do
   {
       email: "standard@bloc.io",
       password: "blochead",
       role: 0
   }
 end

 let(:new_premium_user_attributes) do
  {
      email: "premium@bloc.io",
      password: "blochead",
      role: 1
  }
end

let(:new_admin_user_attributes) do
 {
     email: "admin@bloc.io",
     password: "blochead",
     role: 2
 }
end


###### ADMIN USER ########
  describe "admin user sign in" do
    login_admin_user

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "should get index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


###### PREMIUM USER ########
  describe "premium user sign in" do
    login_premium_user

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "should get index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


###### STANDARD USER ########
  describe "standard user sign in" do
    login_standard_user

    it "should have a current_user" do
      expect(subject.current_user).to_not eq(nil)
    end

    it "should get index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "downgrade from premium to standard" do
  	login_premium_user

  	it "should change the role from premium to standard" do
  		post :downgrade
  		expect(subject.current_user.role).to eq('standard')
  	end
  end

end
