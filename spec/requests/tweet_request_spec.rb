require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /tweets" do
    let!(:user) { create(:user) }
    let!(:older_tweet) { create(:tweet, user: user, created_at: 2.days.ago) }
    let!(:newer_tweet) { create(:tweet, user: user, created_at: 1.day.ago) }

    it "returns tweets ordered by created_at descending" do
      get "/tweets"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["tweets"].size).to eq(2)
      expect(json["tweets"].first["id"]).to eq(newer_tweet.id)
    end

    it "filters tweets by user_id" do
      other_user = create(:user)
      create(:tweet, user: other_user)

      get "/tweets", params: { user_id: user.id }
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["tweets"].all? { |tweet| tweet["user_id"] == user.id }).to be true
    end

    it "paginates tweets with before_time" do
      create(:tweet, user: user, created_at: 3.days.ago)

      get "/tweets", params: { before_time: 1.5.days.ago.iso8601 }
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["tweets"].any? { |tweet| tweet["id"] == newer_tweet.id }).to be false
    end

    it "returns error for invalid before_time format" do
      get "/tweets", params: { before_time: "invalid-time-format" }
      json = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(json["error"]).to eq("Invalid timestamp format")
    end

    it "limits the number of tweets to 10" do
      create_list(:tweet, 15, user: user)

      get "/tweets"
      json = JSON.parse(response.body)

      expect(json["tweets"].size).to eq(10)
    end

    it "includes next_cursor in the response" do
      get "/tweets"
      json = JSON.parse(response.body)

      expect(json).to have_key("next_cursor")
    end
  end
end
