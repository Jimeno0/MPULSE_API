require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it "create a user" do
      user = User.create(name: "carlosperez",password:"111222333",email: "carlosc@icloud.com")
      expect(user).to eq(User.last)
    end
    it "generates a token on create" do
      user = User.create(name: "carlosperez",password:"111222333",email: "carlosc@icloud.com")
      expect(user.token).to be_truthy
    end
    it "create a user" do
      user = User.create(name: "carlosperez",password:"111222333",email: "carlosc@icloud.com")
      expect(user).to eq(User.last)
    end
    context "when field empty" do
      it "password cant be empty" do
        user = User.create(name: "carlosperez",password:"",email: "carlosc@icloud.com")
        expect(user.token).to be_falsey
      end
      it "usesr cant be empty" do
        user = User.create(name: "",password:"123123",email: "carlosc@icloud.com")
        expect(user.token).to be_falsey
      end
      it "email cant be empty" do
        user = User.create(name: "carlosperez",password:"123123",email: "")
        expect(user.token).to be_falsey
      end
    end
    context "email field validation " do
      it "password.size > 8" do
        user = User.create(name: "carlosperez",password:"123123",email: "carlosc@icloud.com")
        expect(user.token).to be_falsey
      end
    end
    context "email field validation " do
      it "email to be unique" do
        User.create(name: "carlosperez",password:"12312312",email: "carlosc@icloud.com")
        user2 = User.create(name: "carlospe",password:"12312333",email: "carlosc@icloud.com")
        expect(user2.token).to be_falsey
      end
      it "email needs @ " do
        user = User.create(name: "carlospe",password:"12312333",email: "carloscicloud.com")
        expect(user.token).to be_falsey
      end
      it "email needs . " do
        user = User.create(name: "carlospe",password:"12312333",email: "carlos@cicloudcom")
        expect(user.token).to be_falsey
      end
    end
  end
end


