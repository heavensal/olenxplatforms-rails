require 'rails_helper'

RSpec.describe "Admin::Portfolios", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/portfolios/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/portfolios/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/portfolios/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
