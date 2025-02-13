require 'rails_helper'

RSpec.describe "Others::Pages", type: :request do
  describe "GET /home" do
    it "returns http success" do
      get "/others/pages/home"
      expect(response).to have_http_status(:success)
    end
  end
end
