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
    before(:each) do
      @user = User.create(name:"Artistslover2", email:"Artistslover2@Artistslover.com",password:"123123123")
      @user2 = User.create(name:"Artistslover3", email:"Artistslover3@Artistslover.com",password:"123123123")
      Artist.create(name: "Moderat")
      @token = @user.token
    end

    context "when artist is not an user's favorite" do
      it "returns error 400 " do
        post :destroy, token: @token, artists: {name: "Moderat"}
        expect(response).to have_http_status(400)
      end
      it "return error msg " do
        post :destroy, token: @token, artists: {name: "Moderat"}
        expect(JSON.parse(response.body)["error"]).to eq("user dont have this artist as favourite")
      end
    end

    context "when artist is an user's favorite" do
      before(:each) do
        @artist = Artist.create(name: "Apparat")
        @user.artists.push(@artist)
      end
      it "returns 200 status" do
        post :destroy, token: @token, artists: {name: "Apparat"}
        expect(response).to have_http_status(200)
      end

      it "deletes the artist form DDBB if only belongs to one user" do
        post :destroy, token: @token, artists: {name: "Apparat"}
        expect(Artist.find_by(name: "Apparat")).to be_nil
      end

      it "removes de connection if belongs to more than one user" do
        @user2.artists.push(@artist)
        post :destroy, token: @token, artists: {name: "Apparat"}
        expect(Artist.find_by(name: "Apparat")).to be_truthy
      end
    end

  end
end
