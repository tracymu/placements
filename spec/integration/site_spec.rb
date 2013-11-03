require 'spec_helper'

describe Site do

  describe "create" do
    before do
      @client = Fabricate(:client)
      visit client_path(@client)
    end

    it "allows creation of sites" do
      click_link "Add New Site"
      fill_in "Name", with: Faker::Company.name
      fill_in "URL",  with: Faker::Internet.http_url
      click_button "Create Site"
      page.should have_content("created")
    end

    it "fails without valid parameters" do
      click_button "Create Site"
      page.should have_content("can't be blank")
    end
  end
end
