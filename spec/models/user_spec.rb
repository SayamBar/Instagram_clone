require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation test" do
    let(:user_1) { User.new(email:"jhwkrtn.com",password:"907306",name:"sayam bar",gender:"Male")}
    let(:user_2) { User.new(email:"jhwkrtn@gmail.com",password:"907306",name:"sayam bar",gender:"Male")}
    let(:user_3) { User.new(email:"jhwkrtn@gmail.com",password:"907306",name:"sayam bar",gender:"Male")}
    # let!(:user_3) { User.create()}
    context "when the email is invalid" do
      it 'ensures user cannot be created' do
        expect(user_1.save).to eq(false)
      end
    end
    context "when the email is valid" do
      it 'ensures user be created' do
        expect(user_2.save).to eq(true)
      end
    end
    context 'duplicate email' do
      it "ensures invalid user" do
        user_2.save
        expect(user_3.save).to eq(false)
      end
    end
  end
  describe '.authentication' do
    let!(:user1) { create(:user) }
    context "when the password is correct" do
      it "ensures log in the user" do
        # debugger
        expect(User.authenticate("admin@gmail.com", "password")).to eq(user1)
      end
    end
    context "when the password is incorrect" do
      it "ensures user can't log in" do
        expect(User.authenticate("admin@gmail.com", "passwords")).to eq(nil)
      end
    end
  end

  describe "length of user's bio test" do
    let(:user) { User.new(email: "test@example.com", password: "password", name:"test", bio:"wjhfbhbje iuwhfjiwehbifj iuwhifjwhf iwhfiwheqf iqhwnkjwqnfjk",gender:"Others")}
    let(:user1) { User.new(email: "test123@example.com", password: "password", name:"test", bio:"wfjhwbejf",gender:"Others")}
    context "when exceeds the length of bio" do
      it "ensures user can't be saved" do
        expect(user.save).to eq(false)
      end
    end
    context "when the length of bio in limit" do
      it "ensures user be saved" do
        # debugger
        expect(user1.save).to eq(true)
      end
    end
  end

  describe "check avatar" do
    let!(:user) { create(:user)}
    context "when user did not upload avatar" do
      it "ensures user has no avatar" do
        expect(user.avatar.attached?).to eq(true)
      end
    end
    context "when user upload avatar" do
      it "ensures user has one avatar" do
        user.avatar.attach(io: File.open("../Downloads/123.jpeg"),filename: '123.jpeg', content_type: 'image/jpeg')
        expect(user.avatar.attached?).to eq(true)
      end
    end
  end

end
