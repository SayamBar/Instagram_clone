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

    context "GET /posts/new" do
      it "renders the new page" do
        params = {caption:"Videos",user_id: user1.id}
        get posts_path(params)
        # debugger
        expect(response).to be_successful
      end
    end
  end
end
