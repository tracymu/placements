require 'spec_helper'
# So the purpose of this feature: every target site will offer certain types of 'placements'. 
# e.g. you could place an image ad, text ad, sponsored post, competition, etc.
# I want us to be able to choose one of these types, and also if they offer a type that 
# doesn't already exist in the database, should be able to add it.



describe Placement_Type do

  describe "create" do
    before do
      @target = Fabricate(:target)
      visit target_path(@target)
      click_link "Add Placement Type"
    end

    it "allows creation of new placement types offered" do
      # fill_in "Name", with: Faker::Company.name
      click_button "Add Placement Type"
      page.should have_content(@placement_type.name)
    end

    it "allows choice of existing placement types" do
      check @placement_type.name
      click_button "Add Placement Type"
      page.should have_content(@placement_type.name)
    end

    it "fails without valid parameters" do
      click_button "Create Site"
      page.should have_content("can't be blank")
    end
  end
end
