require 'rails_helper'

RSpec.describe "Portfolios", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/portfolios/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/portfolios/show"
      expect(response).to have_http_status(:success)
    end
  end
end
