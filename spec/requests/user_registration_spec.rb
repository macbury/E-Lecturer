require "spec_helper"

describe "user registration" do
  it "allows new users to register with an email address and password" do
    visit "/users/sign_up"

    within("#new_user") do
      fill_in "user_email",                 :with => "alindeman@example.com"
      fill_in "user_password",              :with => "ilovegrapes"
      fill_in "user_password_confirmation", :with => "ilovegrapes"

      click_button "create_user"
    end
    #page.should have_content("Welcome! You have signed up successfully.")

  end
end