require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let!(:company1) { create(:company, name: 'Acme Corp') }
  let!(:company2) { create(:company, name: 'Beta Inc') }

  let!(:user1) { create(:user, username: 'john_doe', company: company1) }
  let!(:user2) { create(:user, username: 'jane_doe', company: company2) }

  it "is valid with valid attributes" do
    tweet = Tweet.new(user: user1, body: "This is a test tweet")
    expect(tweet).to be_valid
  end


  it "is not valid without content" do
    tweet = Tweet.new(user: user2, body: nil)
    expect(tweet).to_not be_valid
  end

  it "is not valid without a user" do
    tweet = Tweet.new(user: nil, body: "This is a test tweet")
    expect(tweet).to_not be_valid
  end
end
