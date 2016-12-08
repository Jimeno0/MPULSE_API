require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    before(:all) do
      user = User.create(name:"Chiquitor", email:"chiquitor@dinamita.com",password:"123123123")
      @token = user.token
    end
    context "on invalid user or password " do
      it "gets 400 status with no params" do
        post :create
        expect(response).to have_http_status(400)
      end
      it "gets an error message" do
        post :create
        expect(JSON.parse(response.body)["error"]).to eq("invalid user or password")
      end
      it "gets 400 status with bad params" do
        post :create, name: "Fran", password: "11111111", email: "fran@noexiste.com"
        expect(response).to have_http_status(400)
      end
    end
    context "when correct user and password" do
      before(:each) do
        post :create, name:"Chiquitor", email:"chiquitor@dinamita.com", password:"123123123"
        @new_token = JSON.parse(response.body)["token"]
      end
      it "creates a new token" do
        expect(@new_token).not_to be(@token)
      end

      it "gets 200 status" do
        expect(response).to have_http_status(200)
      end
      it "gets a token in the body" do
        expect(@new_token).to be_truthy
      end
    end
  end
  describe "POST #destroy" do
    before(:each) do
      @user = User.create(name: "Manolete", password: "123123123", email:"manolete33@email.com")
      post :destroy, token: @user.token, user: @user
    end
    it "gets 200 status" do
      expect(response).to have_http_status(200)
    end
    it "responds nil token" do
      expect(JSON.parse(response.body)["token"]).to be_nil
    end
  end
end