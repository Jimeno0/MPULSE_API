require "rails_helper"

RSpec.describe ConcertsController, type: :controller do
  describe "POST #last" do
    context "when it works" do
      it "returns 200 status" do
        post :last
        expect(response).to have_http_status(200)
      end
      it "returns an array of 8" do
        post :last
        expect(JSON.parse(response.body).size).to eq(8)
      end
      it "has a name property" do
        post :last
        expect(JSON.parse(response.body)[0]["name"]).to be_truthy
      end
      it "has an image property" do
        post :last
        expect(JSON.parse(response.body)[0]["venue"]).to be_truthy
      end
      it "has a date property" do
        post :last
        expect(JSON.parse(response.body)[0]["date"]).to be_truthy
      end
    end

  end

  describe "POST #search " do
    context "when it works" do
      it "returns 200 status" do
        post :search, search: "Claptone"
        expect(response).to have_http_status(200)
      end
      it "has a name property" do
        post :search, search: "Claptone"
        expect(JSON.parse(response.body)[0]["name"]).to be_truthy
      end
      it "has an image property" do
        post :search, search: "Claptone"
        expect(JSON.parse(response.body)[0]["venue"]).to be_truthy
      end
      it "has a date property" do
        post :search, search: "Claptone"
        expect(JSON.parse(response.body)[0]["date"]).to be_truthy
      end
    end
    context "when artist doesnt exists" do
      it "returns 404 status" do
        post :search, search: "Clap"
        expect(response).to have_http_status(404)
      end
      it "has a name property" do
        post :search, search: "Clap"
        expect(JSON.parse(response.body)["error"]).to eq("No concerts for this artist yet")
      end
    end
    #si el resultado es vacío? Error ver que da en error que venga de ticketmaster
    #para alguna otra petción
  end
end
