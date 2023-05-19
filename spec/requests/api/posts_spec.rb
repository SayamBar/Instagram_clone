require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  describe "GET api/v1/posts" do
    let(:user) { create(:user) }
    let(:application) { Doorkeeper::Application.create!(name: "Test App", redirect_uri: "") }
    let(:access_token) { Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: user.id, expires_in: Doorkeeper.configuration.access_token_expires_in.to_i) }
    context "with a valid access token" do
      it "renders the all posts in the page" do
        # debugger
        get '/api/v1/posts', headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        # debugger
        expect(response).to be_successful
      end
    end

    context "without an access token" do
      it "returns an unauthorized response" do
        get '/api/v1/posts'
        expect(response).to have_http_status(401)
      end
    end 
    
    context "with a revoked access token" do
      before do
        access_token.revoke
      end
      it "returns an unauthorized response" do
        get '/api/v1/posts', headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(401)
      end
    end 

    context "with a valid access token and params" do
      it "returns record not found" do
        get api_v1_posts_path,params: {caption_starts_with: "abc"}, headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        # debugger
        expect(response).to have_http_status(404)
      end

      let!(:post) { create(:post, user_id: user.id) }
      it "renders the filtered posts" do
        # debugger
        get api_v1_posts_path,params: {caption_starts_with: "cb"}, headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(200)
      end
    end
  end
end
