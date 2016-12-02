require "rails_helper"

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    context "on error " do
      it "responds 400 status with no params" do
        get :create
        expect(response).to have_http_status(400)
      end
      it "responds error with bad email" do
        post :create, name: "Manolete",
          password: "123123123",
          email:"manoleteMailemail.com"
        expect(response).to have_http_status(400)
      end


      it "responds an error" do
        get :create
        expect(JSON.parse(response.body)["error"]).to eq("cannot create user")
      end
    end

    context "on success" do
      before(:each) do
        post :create, name: "Manolete",
          password: "123123123",
          email:"manoleteMail@email.com"
      end

      it "responds 201 status when valid params" do
        expect(response).to have_http_status(201)
      end

      it "increases the users number by 1" do
        expect(User.last.email).to eq("manoleteMail@email.com")
      end

      it "responds name and token in json valid params" do
        expect(JSON.parse(response.body)["token"]).to be_truthy
      end

      it "takes returns name" do
        expect(JSON.parse(response.body)["name"]).to eq("Manolete")
      end
    end
  end

  describe "on bad token" do
    before(:each) do
      post :update, token: ""
    end
    it "gets error 404" do
      expect(response).to have_http_status(404)
    end
    it "gets error msg"  do
      expect(JSON.parse(response.body)["error"]).to eq("user not found")
    end
  end


  describe "POST #update" do
    before(:each) do
        @user = User.create(name: "Manolete",password: "123123123",email:"manolete33@email.com")
    end

    context "on bad params to update" do
      before(:each) do
        token = @user.token
        post :update, token: token, email: "manoleteteteemail.com"
      end
      it "gets error 404" do
        expect(response).to have_http_status(400)
      end
      it "gets error msg"  do
        expect(JSON.parse(response.body)["error"]).to eq("cannot update user")
      end
    end

    context "on good params" do
      before(:each) do
        @token = @user.token
        post :update, token: @token, name: "feredico"
      end

      it "gets status 201" do
        expect(response).to have_http_status(201)
      end

      it "gets the token"  do
        expect(JSON.parse(response.body)["token"]).to be_truthy
      end

      it "gets the new param"  do
        expect(JSON.parse(response.body)["name"]).to eq("feredico")
      end
    end
  end

  describe "POST #destroy" do
    before(:each) do
      @user = User.create(name: "Manolete",password: "123123123",email:"manolete33@email.com")
      @token = @user.token
      @size = User.all.size
      post :destroy, token: @token
    end
    it "gets status 200" do
      expect(response).to have_http_status(200)
    end
    it "gets the new param"  do
      expect(JSON.parse(response.body)["name"]).to eq("Manolete")
    end
    it "is no longer the last item"  do
      expect(User.all.size+1).to eq(@size)
    end
  end
end