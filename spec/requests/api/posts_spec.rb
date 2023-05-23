require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  let(:user) { create(:user) }
  let(:application) { Doorkeeper::Application.create!(name: "Test App", redirect_uri: "") }
  let(:access_token) { Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: user.id, expires_in: Doorkeeper.configuration.access_token_expires_in.to_i) }
  describe "GET api/v1/posts" do
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
      it "returns empty array" do
        get api_v1_posts_path,params: {caption_starts_with: "abc"}, headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        # debugger
        expect(response).to have_http_status(200)
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

  describe "GET api/v1/posts/:id" do
    context "with a valid token and params" do
      let!(:post) { create(:post, user_id:user.id) }
      it "renders the specific post" do
        get api_v1_post_path(post), headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(200)
      end

      it "returs record not found" do
        get api_v1_post_path(12), headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(404)
      end
    end

    context "without an access token" do
      let!(:post) { create(:post, user_id:user.id) }
      it "returns an unauthorized response" do
        get api_v1_post_path(post)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST api/v1/posts" do
    context "with a valid token and params" do
      it "creates a new post" do
        post api_v1_posts_path,params: {caption: "New"}, headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(201)
      end
    end

    context "with a valid token but without params" do
      it "creates a new post" do
        post api_v1_posts_path, headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(422)
      end
    end

    context "without an access token" do
      it "returns an unauthorized response" do
        post api_v1_posts_path,params: {caption: "New"}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "PATCH api/v1/posts/:id" do
    context "with a valid token and params" do
      let!(:post) { create(:post, user_id:user.id) }
      it "updates an existing post" do
        patch api_v1_post_path(post), headers: { 
         "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(200)
      end

      it "returns record not found" do
        patch api_v1_post_path(12), headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(404)
      end

      let!(:user1) { create(:user, email: "sayam@gmail.com") }
      let!(:post1) { create(:post, user_id: user1.id) }
      it "returns forbidden status" do
        patch api_v1_post_path(post1), headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(403)
      end
    end

    context "without an access token" do
      let!(:post) { create(:post, user_id:user.id) }
      it "returns an unauthorized response" do
        patch api_v1_post_path(post)
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE api/v1/posts/:id" do
    context "with a valid token and params" do
      let!(:post) { create(:post, user_id:user.id) }
      it "deletes an existing post" do
        delete api_v1_post_path(post), headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
         }
        expect(response).to have_http_status(200)
      end

      it "returns record not found" do
        delete api_v1_post_path(12), headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
         }
        expect(response).to have_http_status(404)
      end

      let!(:user1) { create(:user, email: "sayam@gmail.com") }
      let!(:post1) { create(:post, user_id: user1.id) }
      it "returns forbidden status" do
        delete api_v1_post_path(post1), headers: { 
          "Authorization" => "Bearer #{access_token.token}" 
        }
        expect(response).to have_http_status(403)
      end
    end

    context "without an access token" do
      let!(:post) { create(:post, user_id:user.id) }
      it "returns an unauthorized response" do
        delete api_v1_post_path(post)
        expect(response).to have_http_status(401)
      end
    end
  end
end
