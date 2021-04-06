require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe "新規ユーザー登録" do
    let(:user) { build(:user, name: "user", email: "user@example.com", gender: "man") }

    before do
      visit new_user_registration_path
    end

    context "入力したユーザー情報が有効な場合" do
      it "ユーザー登録後トップページへ遷移すること" do
        fill_in "メールアドレス", with: user.email
        fill_in "名前", with: user.name
        fill_in "パスワード", with: user.password
        choose "user_gender_man"
        click_on "登録する"
        expect(current_path).to eq root_path
        expect(page).not_to have_content("新規登録")
        expect(page).not_to have_content("ログイン")
      end
    end

    context "入力したユーザー情報が無効な場合" do
      it "再度、新規登録ページが表示される" do
        fill_in "メールアドレス", with: ""
        fill_in "名前", with: user.name
        fill_in "パスワード", with: user.password
        choose "user_gender_man"
        click_on "登録する"
        expect(current_path).to eq "/users"
        expect(page).not_to have_content("登録情報")
        expect(page).not_to have_content("ログアウト")
      end
    end
  end

  describe "ログイン" do
    let(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }

      before do
        visit new_user_session_path
      end

    context "入力情報が存在する場合" do
      it "ログイン後、トップページへ遷移すること" do
        fill_in "Eメール", with: user.email
        fill_in "パスワード", with: user.password
        click_on "Log in"
        expect(current_path).to eq root_path
        expect(page).not_to have_content("新規登録")
        expect(page).not_to have_content("/^ログイン$/")
      end
    end

    context "入力情報が誤っている場合" do
      it "ログイン後、トップページへ遷移すること" do
        fill_in "Eメール", with: ""
        fill_in "パスワード", with: user.password
        click_on "Log in"
        expect(current_path).to eq new_user_session_path
        expect(page).not_to have_content("登録情報")
        expect(page).not_to have_content("ログアウト")
      end
    end
  end

  describe "マイページの編集" do
    let!(:user) { create(:user, name: "user", email: "user@example.com", gender: "man") }

      before do
        sign_in(user)
        visit edit_user_registration_path
      end

    context "有効なプロフィール情報を入力した場合" do
      it "更新されたユーザー情報が表示されること" do
        fill_in "メールアドレス", with: "user_2@example.com"
        fill_in "名前", with: user.name
        fill_in "パスワード", with: user.password
        fill_in "パスワードの確認", with: user.password_confirmation
        click_on "保存"
        expect(current_path).to eq "/users/#{user.id}"
        expect(user.reload.email).to eq "user_2@example.com"
      end
    end

    context "無効なプロフィール情報を入力した場合" do
      it "更新されず再度、編集画面が表示されること" do
        fill_in "メールアドレス", with: ""
        fill_in "名前", with: user.name
        fill_in "パスワード", with: user.password
        fill_in "パスワードの確認", with: user.password_confirmation
        click_on "保存"
        expect(page). to have_content "Eメールを入力してください"
        expect(user.reload.email).not_to eq ""
      end
    end
  end
end
