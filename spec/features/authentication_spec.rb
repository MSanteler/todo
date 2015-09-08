require 'rails_helper'

describe "Visiting Home", :type => :feature do
  before :each do
    
  end

  it "Expects Authentication" do
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  it "lets you log-in and redirects to welcome#index" do
    @user = FactoryGirl.create(:user)
    login_user(@user)
    
    expect(page).to have_content 'Signed in successfully.'
  end

end