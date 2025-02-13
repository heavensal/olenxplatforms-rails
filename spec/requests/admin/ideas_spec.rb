require 'rails_helper'

RSpec.describe "Admin::Ideas", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/ideas/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/ideas/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/ideas/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
