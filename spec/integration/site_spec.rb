require 'spec_helper'

describe Site do

  describe "create" do
    before do
      @client = Fabricate(:client)
      visit client_path(@client)
      click_link "Add New Site"
    end

    it "allows creation of sites" do
      fill_in "Name", with: Faker::Company.name
      fill_in "Url",  with: Faker::Internet.http_url
      click_button "Create Site"
      page.should have_content("created")
    end

    it "fails without valid parameters" do
      click_button "Create Site"
      puts page.body
      puts page.current_path
      page.should have_content("can't be blank")
    end
  end
end
