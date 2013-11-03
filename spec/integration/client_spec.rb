require 'spec_helper'

describe Client do

  describe "create" do
    before do
      visit new_client_path
    end

    it "allows creation of clients" do
      name = "Brenton's Awesome Pork Sandwiches"
      fill_in "Name", with: name
      click_button "Create Client"
      page.should have_content("created")
    end

    it "fails without valid name" do
      click_button "Create Client"
      page.should have_content("can't be blank")
    end
  end
end
