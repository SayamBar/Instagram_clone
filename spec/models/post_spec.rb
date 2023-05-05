require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { User.create(email:"sayam@gmail.com", password:"jhebrjfbejfwe") }
  let(:post_1) { Post.new(caption:"cbh",user_id:user.id) }
  context 'validation test' do
    it 'ensures post is valid' do
      debugger
      expect(post_1.save).to eq(true)
    end
  end

  it 'has caption' do
    expect(post_1.caption).to eq('cbh')
  end
end
