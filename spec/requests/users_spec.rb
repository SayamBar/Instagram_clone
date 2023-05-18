require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "Route test" do
    context "GET registrations/new" do
      it "renders the sign up page" do
        get new_user_registration_path 
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "GET sessions/new" do
      it "renders the log in page" do
        get new_user_session_path 
        expect(response).to have_http_status(:ok)
      end
    end

    context "GET registrations/edit" do
      it "redirected to log in page" do
        get edit_user_registration_path
        expect(response).to have_http_status(302)
      end
    end

    context "GET registrations/edit" do
      let!(:user1) { create(:user)}
      it "render to user edit page" do
        allow_any_instance_of(ApplicationController).to receive(:authenticate_user!)
        allow_any_instance_of(ApplicationController).to receive(:user_signed_in?).and_return(true)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
        get edit_user_registration_path
        expect(response).to have_http_status(200)
      end
    end
  
  end

end
