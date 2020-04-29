require 'rails_helper'

RSpec.describe Administrator, type: :model do
  describe "#password=" do
    example "文字列を与えると、hashed_passwordは長さ60の文字列になる" do
      member = Administrator.new
      member.password = "cms01"
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example "nilを与えると、hashed_password は nilになる" do
      member = Administrator.new(hashed_password: "X")
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end
end
