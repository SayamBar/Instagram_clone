require 'rails_helper'

RSpec.describe Post, type: :model do
  # let!(:user) { User.create(email:"sayam@gmail.com", password:"jhebrjfbejfwe") }
  let(:user1) { build(:user) }
  before(:each) do
    user1.save
  end
  describe "validation test" do
    let(:post1) { build(:post ,user_id:user1.id) }
    context 'post creation' do
      it 'ensures post is valid' do
        expect(post1.save).to eq(true)
      end
      
      let(:post2) { build(:post)}
      it "ensures post is invalid" do 
        expect(post2.save).to eq(false)
      end
      
      let(:post3) { Post.new(user_id:user1.id)}
      it "ensures post is invalid" do 
        expect(post3.save).to eq(false)
      end
      
      it "ensures attachment not present" do
        expect(post1.image.attached?).to eq(false)
      end
    end
  end

  describe "check association" do
    let(:post2) { create(:post ,user_id:user1.id) }
    it "ensures initially post has zero likes" do
      expect(post2.likes.count).to eq(0)
    end
    
    it "ensures initially post has zero comments" do
      expect(post2.comments.count).to eq(0)
    end
    
    let(:post1) { create(:post ,user_id:user1.id) }
    let!(:user2) { User.create(email:"bar@gmail.com", password:"123456", name:"bar", bio:"rgerg ergehj", gender:"male")}
    let!(:like1) { Like.create(user_id:user2.id, likeable_type:"Post", likeable_id:post1.id)}
    context "when anyone like a post" do
      it "ensures number of likes increase for the post" do
        expect(post1.likes.count).to eq(1)
      end
    end

    let!(:comment1) { Comment.create(comment:"Woh!!", user_id:user2.id, post_id:post1.id)}
    context "when anyone comment a post" do
      it "ensures comment is being saved for the post" do
        expect(post1.comments.count).to eq(1)
      end
    end
  end
end
