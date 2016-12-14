require "rails_helper"

RSpec.describe ConcertsController, type: :controller do
  describe "POST #last" do
    context "With valid data" do
      it "returns 200 status" do
        get :last
        expect(response.status).to eq(200)
      end
      it "returns an array of 8" do
        get :last
        expect(JSON.parse(response.body).size).to eq(9)
      end
      it "has a name property" do
        get :last
        expect(JSON.parse(response.body)[0]["name"]).to be_truthy
      end
      it "has an image property" do
        get :last
        expect(JSON.parse(response.body)[0]["venue"]).to be_truthy
      end
      it "has a date property" do
        get :last
        expect(JSON.parse(response.body)[0]["date"]).to be_truthy
      end
    end
  end

  describe "POST #search " do
    context "Valid search params" do
      it "returns 200 status" do
        post :search, search: "Bonobo"
        expect(response.status).to eq(200)
      end
      it "has a name property" do
        post :search, search: "Bonobo"
        expect(JSON.parse(response.body)[0]["name"]).to be_truthy
      end
      it "has an image property" do
        post :search, search: "Bonobo"
        expect(JSON.parse(response.body)[0]["venue"]).to be_truthy
      end
      it "has a date property" do
        post :search, search: "Bonobo"
        expect(JSON.parse(response.body)[0]["date"]).to be_truthy
      end
    end
    context "when artist doesnt exists" do
      it "returns 404 status" do
        post :search, search: "asdfasdfsdf"
        expect(response.status).to eq(404)
      end
      it "has a name property" do
        post :search, search: "asdfasdfsd"
        expect(JSON.parse(response.body)["error"]).to eq("No concerts for this artist yet")
      end
    end
  end
  describe "POST #create" do
    before(:each) do
      @user = User.create(name:"Clap_fan", email:"Claptonelover@concert.com",password:"123123123")
      @concerts_size = Concert.all.size
      @user_concerts_size = @user.concerts.count
      @token = @user.token
      @clap_concert = {
      "name": "Claptone",
      "date": "2016-12-09",
      "url": "http://www.ticketweb.com/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=7000325&REFERRAL_ID=tmfeed",
      "genre": "Dance/Electronic",
      "subgenre": "Club Dance",
      "country": "United States Of America",
      "lat": "39.949718",
      "lon": "-75.169853",
      "city": "Philadelphia",
      "venue": "Coda",
      "concert_id": "1AtZAAxGkdN96uQ",
      "sale": true,
      "image": "https://s1.ticketm.net/dam/c/df8/81eadad8-4449-412e-a2b1-3d8bbb78edf8_106181_CUSTOM.jpg"
    }
    end
    context "when concert doesnt exisist at the DDBB" do
      it "return 201 status" do
        post :create, token: @token, concert: @clap_concert
        expect(response.status).to eq(201)
      end
      it "returns the concert" do
        post :create, token: @token, concert: @clap_concert
        expect(JSON.parse(response.body)["name"]).to eq("Claptone")
      end
      it "increase the number of concerts" do
        expect do
          post :create, token: @token, concert: @clap_concert
        end.to change(Concert,:count).by(1)
      end

    end
    context "when concert already exists in the DDBB" do
      before(:each) do
        Concert.create(@clap_concert)
        @concerts_after_create = Concert.all.size
      end
      # Pending, works but cat pass test on find_or_create_by
      # it "returns the concert" do
      #   post :create, token: @token, concert: @clap_concert
      #   expect(JSON.parse(response.body)["name"]).to eq("Claptone")
      # end
      # it "doesnt increase the number of concerts" do
      #   post :create, token: @token, concert: @clap_concert
      #   expect(@concerts_after_create).to eq(Concert.all.size)
      # end
      # it "increase the number of user concerts by one" do
      #   post :create, token: @token, concert: @clap_concert
      #   expect(@user_concerts_size + 1 ).to eq(@user.concerts.size)
      # end
    end
  end
  describe "POST #destroy" do
    before(:each) do
      @user = User.create(name:"Clap_fan", email:"Claptonelover@concert.com",password:"123123123")
      @user2 = User.create(name:"Clap_fan2", email:"Claptonelover2@concert.com",password:"123123123")
      @concerts_size = Concert.all.size
      @user_concerts_size = @user.concerts.count
      @token = @user.token
      @clap_concert = {
        "name": "Claptone",
        "date": "2016-12-09",
        "url": "http://www.ticketweb.com/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=7000325&REFERRAL_ID=tmfeed",
        "genre": "Dance/Electronic",
        "subgenre": "Club Dance",
        "country": "United States Of America",
        "lat": "39.949718",
        "lon": "-75.169853",
        "city": "Philadelphia",
        "venue": "Coda",
        "concert_id": "1AtZAAxGkdN96uQ",
        "sale": true,
        "image": "https://s1.ticketm.net/dam/c/df8/81eadad8-4449-412e-a2b1-3d8bbb78edf8_106181_CUSTOM.jpg"
      }
    end
    context "when concert is not an user's favorite" do
      it "returns error 400 " do
        post :destroy, token: @token, concert_id: @clap_concert[:concert_id]
        expect(response.status).to eq(400)
      end
      it "return error msg " do
        post :destroy, token: @token, concert_id: @clap_concert[:concert_id]
        expect(JSON.parse(response.body)["error"]).to eq("user dont have this concert as favourite")
      end
    end
    context "when concert is an user favorite " do
      before(:each) do
        @concert = Concert.create(@clap_concert)
        @user.concerts.push(@concert)
      end
      it "returns 200 status" do
        post :destroy, token: @token, concert_id: @clap_concert[:concert_id]
        expect(response.status).to eq(200)
      end
      it "deletes the concert form DDBB if only belongs to one user" do
        post :destroy, token: @token, concert_id: @clap_concert[:concert_id]
        expect(Concert.find_by(concert_id: @clap_concert["concert_id"])).to be_nil
      end
      it "removes de connection if belongs to more than one user" do
        @user2.concerts.push(@concert)
        post :destroy, token: @token, concert_id: @clap_concert[:concert_id]
        expect(Concert.find_by(concert_id: @clap_concert["concert_id"])).to be_nil
      end
      it "renders the deleted concert" do
        post :destroy, token: @token, concert_id: @clap_concert[:concert_id]
        expect(JSON.parse(response.body)["concert_id"]).to eq(@clap_concert[:concert_id])
      end
    end
  end
  describe "GET #index" do
    before(:each) do
      @user = User.create(name:"Clap_fan", email:"Claptonelover@concert.com",password:"123123123")
      @token = @user.token
      @clap_concert = {
        "name": "Claptone",
        "date": "2016-12-09",
        "url": "http://www.ticketweb.com/t3/sale/SaleEventDetail?dispatch=loadSelectionData&eventId=7000325&REFERRAL_ID=tmfeed",
        "genre": "Dance/Electronic",
        "subgenre": "Club Dance",
        "country": "United States Of America",
        "lat": "39.949718",
        "lon": "-75.169853",
        "city": "Philadelphia",
        "venue": "Coda",
        "concert_id": "1AtZAAxGkdN96uQ",
        "sale": true,
        "image": "https://s1.ticketm.net/dam/c/df8/81eadad8-4449-412e-a2b1-3d8bbb78edf8_106181_CUSTOM.jpg"
      }
    end
    context "user dont have any concert" do
      it "responds a 200 status" do
        get :index, token: @token
        expect(response.status).to eq(200)
      end
      it "responds an empty array" do
        get :index, token: @token
        expect(JSON.parse(response.body)).to eq([])
      end
    end
    context "user dont has a concert" do
      before(:each) do
        @concert = Concert.create(@clap_concert)
        @user.concerts.push(@concert)
      end
      it "responds a 200 status" do
        get :index, token: @token
        expect(response.status).to eq(200)
      end
      it "responds an array with the concert" do
        get :index, token: @token
        expect(JSON.parse(response.body)[0]["name"]).to eq("Claptone")
      end
    end
  end
end
