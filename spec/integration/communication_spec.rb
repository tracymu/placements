require 'spec_helper'

describe "Target Communications" do 
# Not sure if this is the class I should be testing. I chose it because this functionality is looking at the
# communication between sites and targets

	before do
		@site = Fabricate(:site)
		@new_target = Fabricate(:target)
		Fabricate(:site_target, site: @site, target: @new_target)
		@contacted_target = Fabricate(:target)
		Fabricate(:contacted_site_target, site: @site, target: @contacted_target)
	end

	describe "site show page" do

	  before do
	    visit client_site_path(@site.client, @site)
	  end

	  it "lists only new site.targets that haven't been contacted" do
	  	within(".targets.new") do
	    	page.should have_content(@new_target.name)
	    	page.should_not have_content(@contacted_target.name)
	  	end
	  end

	  it "allows to mark target as contacted and removes from page" do
	    click_button "Contacted"
#  I think here I have to separate out into 2 tests
			page.reload
			# is there such a thing?
	    page.should_not have_content(@target.name)
	  end

	  it "records the date the site was contacted" do
	  	click_button "Contacted"
	  	@site_target.contact eql Date.current 
		end

  end

  describe "Page of contacted targets" do

  	before do
	    visit contacted_targets_path
	    # is it ok to make a route like that?
	  end

	  it "lists site.targets that have been contacted" do	    
	    page.should have_content(@site.targets.name.where)
	    	#  list of conditions
	    contacted.exists && do_not_contact == nil && recontacted == nil && details_input == nil
	  end

# I think there should be another describe block here, so each of them can be 2 checks 
#  1. that you can click on the dropdown
#  2. that depending on what you choose, you can write a test for page reload, or date entered.

#  Look for a 'choose from dropdown' capybara command?
	  it "allows to choose recontact as a dropdown" do
	    click_button "Recontacted"
	  	page.reload
	    page.should_not have_content(@target.name)
	  end

		it "allows to choose 'Do Not Contact' as a dropdown" do
	    click_button "Do Not Contact"
	    page.reload
	    page.should_not have_content(@target.name)
	  end

	  it "allows to choose Input Details as a dropdown and redirects to target page" do
	    click_button "Input Details"
	    page.should have_content("Enter Offer Details")
	    # What page shoudl this be? What model???
	  end
  end
end