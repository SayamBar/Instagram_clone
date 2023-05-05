require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_1) { User.new(email:"jhwkrtn.com",password:"907306")}
  let(:user_2) { User.new(email:"jhwkrtn@gmail.com",password:"907306")}
  let!(:user_3) { User.create(email:"barsayam@gmail.com",password:"907306")}
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
  context "when user put correct password" do
    it 'ensures user can log in' do
      expect(User.authenticate("barsayam@gmail.com","907306")).to eq(true)
    end
  end
  context "when user put incorrect password" do
    it 'ensures authentication failed' do
      expect(User.authenticate("barsayam@gmail.com","9073065")).to eq(false)
    end
  end
end
