require 'rails_helper'

RSpec.describe "Dashboard::Projects", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/dashboard/projects/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/dashboard/projects/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/dashboard/projects/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/dashboard/projects/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
