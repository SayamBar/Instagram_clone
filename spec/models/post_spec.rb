require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post_1) {create(caption:"cbh",user_id:1)}
  it 'has caption' do
    expect(post_1.caption).to eq('cbh')
  end
  it 'has caption' do
    post_1 = Post.create(caption:"jbj",user_id:1)
    expect(post_1.caption).to eq("jbj")
  end
end
