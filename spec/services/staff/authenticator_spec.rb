require "rails_helper"

describe Staff::Authenticator do
  describe "#authenticate" do
    example "正しいパスワードなら true を返す" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_truthy
    end

    example "誤ったパスワードを返すなら false を返す" do
      m = build(:staff_member)
      expect(Staff::Authenticator.new(m).authenticate("xy")).to be_falsey
    end

    example "パスワード未設定なら false を返す" do
      m = build(:staff_member, password: nil)
      expect(Staff::Authenticator.new(m).authenticate("nil")).to be_falsey
    end
    
    example "停止フラグが立っていても true を返す" do
      m = build(:staff_member, suspended: true)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_truthy
    end

    example "開始前なら false を返す" do
      m = build(:staff_member, start_date: Date.tomorrow)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    end

    example "終了後なら false を返す" do
      m = build(:staff_member, end_date: Date.today)
      expect(Staff::Authenticator.new(m).authenticate("pw")).to be_falsey
    end
  end
end