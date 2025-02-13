require 'rails_helper'

RSpec.describe "Dashboard::Ideas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/dashboard/ideas/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/dashboard/ideas/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/dashboard/ideas/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/dashboard/ideas/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
