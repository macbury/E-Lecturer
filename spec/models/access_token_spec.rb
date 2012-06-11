require 'spec_helper'

describe AccessToken do
  it "should create random unique access token for user" do
    token = create(:access_token)
    token.code.should_not be_nil
    token.expired?.should be(false)
  end

  it "should proper show expired tokens" do
    token = build(:access_token)
    token.expire_at = 2.days.from_now
    token.expired?.should be(false)
    token.expire_at = 2.days.ago
    token.expired?.should be(true)
  end
end
