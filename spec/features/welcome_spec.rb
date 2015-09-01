require 'rails_helper'

describe "Visiting Home", :type => :feature do
  before :each do
    visit root_path
  end

  it "Expects Authentication" do
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end