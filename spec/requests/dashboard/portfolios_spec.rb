require 'rails_helper'

RSpec.describe "Dashboard::Portfolios", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/dashboard/portfolios/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/dashboard/portfolios/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
