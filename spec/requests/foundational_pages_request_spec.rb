require 'rails_helper'

RSpec.describe "FoundationalPages", type: :request do

  describe "GET /home" do
    it "returns http success" do
      get "/foundational_pages/home"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /help" do
    it "returns http success" do
      get "/foundational_pages/help"
      expect(response).to have_http_status(:success)
    end
  end

end
