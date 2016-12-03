require "rails_helper"

RSpec.describe ArtistsController, type: :controller do
  describe "POST #create" do
    before(:each) do
      user = User.create(name:"Artistslover", email:"Artistslover@Artistslover.com",password:"123123123")
      @token = user.token
    end
    context "when artist already exist" do
      before(:all) do
        artist = Artist.create(name: "Bonobo")
        @name = artist.name
      end
      it "returns 200 status" do
        post :create, token: @token, artists: {name: "Bonobo"}
        expect(response).to have_http_status(200)
      end
      it "returns the artist name" do
        post :create, token: @token, artists: {name: "Bonobo"}
        expect(JSON.parse(response.body)["name"]).to eq(@name)
      end
    end

    context "when artist doesnt exist" do
      it "returns 201 status" do
        post :create, token: @token, artists: {name: "Moderat"}
        expect(response).to have_http_status(201)
      end
      it "returns the artist name" do
        post :create, token: @token, artists: {name: "Moderat"}
        expect(JSON.parse(response.body)["name"]).to eq("Moderat")
      end
      it "error 400 on empty string" do
        post :create, token: @token, artists: {name: ""}
        expect(response).to have_http_status(400)
      end

      it "error msg on empty string" do
        post :create, token: @token, artists: {name: ""}
        expect(JSON.parse(response.body)["error"]).to eq("impossible to create artist")
      end
    end
  end
  describe "POST #destroy" do
    context "when artist is not an user's favourite" do
      before(:all) do
        user = User.create(name:"Artistslover", email:"Artistslover@Artistslover.com",password:"123123123")
        @token = user.token
      end
      it "returns error 400 " do

      end
    end

  end
end
