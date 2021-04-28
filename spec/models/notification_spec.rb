require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }

  describe "バリデーションテスト" do
    context "登録ができるとき" do
      it "有効な情報であれば登録できること" do
        expect(notification).to be_valid
      end
    end

    context "登録ができないとき" do
      it "visitor_idがなければ登録できないこと" do
        notification.visitor_id = nil
        notification.valid?
        expect(notification).to be_invalid
      end
    end
  end
end
