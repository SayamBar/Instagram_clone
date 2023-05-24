require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user1) { create(:user)}
  before(:each) do
    allow_any_instance_of(ApplicationController).to receive(:authenticate_user!)
    allow_any_instance_of(ApplicationController).to receive(:user_signed_in?).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
  end
  describe "Route tests" do
    context "GET /posts" do
      it "renders the index page" do
        # debugger
        get posts_path
        expect(response).to be_successful
      end
    end

    let(:post1) { create(:post, user_id:user1.id) }
    context "GET /posts/:id" do
      it "renders the show page" do
        get posts_path(post1)
        # debugger
        expect(response).to be_successful
      end
    end

    context "POST /posts/new" do
      it "creates a post" do
        post posts_path, params: {post: {caption:"eerER"}}
        # debugger
        expect(response).to have_http_status(302)
      end
    end

    context "PATCH /posts/:id" do
      it "updates a specific post" do
        patch post_path(post1), params: {post: {caption:"kerjfnekj erjkfbkjer"}}
        expect(response).to have_http_status(302)
      end

      let!(:user2) { create(:user, email:"febfwbefjk@gmail.com")}
      let(:post2) { create(:post, user_id:user2.id) }
      it "can't update a specific post" do
        patch post_path(post2), params: {post: {caption:"kerjfnekj erjkfbkjer"}}
        # debugger
        expect(flash[:notice]).to eq("You can't update this post")
      end
    end

    context "DELETE /posts/:id" do
      it "deletes a specific post" do
        delete post_path(post1)
        expect(response).to have_http_status(302)
      end

      let!(:user2) { create(:user, email:"febfwbefjk@gmail.com")}
      let(:post2) { create(:post, user_id:user2.id) }
      it "can't update a specific post" do
        delete post_path(post2)
        # debugger
        expect(flash[:notice]).to eq("You can't delete this post")
      end
    end
  end
end
