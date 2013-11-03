require 'spec_helper'

describe Target do
  describe "create" do
    describe "direct url" do

      before do
        visit new_target_path
      end

      it "allows creation of targets (without sites assigned)" do
        create_target
        page.should have_content("created")
      end

      it "allows assignment of sites" do
        check @site.name
        create_target
        page.should have_content(@site.name)
      end

      it "fails without valid name" do
        click_button "Create Target"
        page.should have_content("can't be blank")
      end
    end

    describe "from site" do
      before do
        @site = Fabricate(:site)
        visit site_path(@site)
        click_link "Add Target"
      end

      it "allows creation of target with site added" do
        create_target
        page.should have_content("created")
        page.should have_content(@site.name)
      end
    end
  end
end

def create_target
  fill_in "Name", with: Faker::Company.name
  fill_in "URL",  with: Faker::Internet.http_url
  click_button "Create Target"
end
