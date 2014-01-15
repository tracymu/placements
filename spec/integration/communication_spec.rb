# Does the name of the spec have to be the name of a class? Because I have it instead as the name of a 
# functionality. These set of tests are about recording communications between sites and targets

# Is this file way too long? How should I cut it up?


# The point of this set of tests is to be able to create the following steps;
#  1. For each site there should be a page where there is a list of targets I have to contact. 
#  This should list only targets that haven't been contacted yet.

#  2. There should be another page that has a list of 'contacted' targets, and any target in that list
#  should have three options i) recontact (only once) ii) Do Not Contact iii) Input Details (which should 
#  redirect to some other page to put in details. (which page? not sure yet)

require 'spec_helper'

describe SiteTarget do 
# Not sure if this is the class I should be testing. I chose it because this functionality is looking at the
# communication between sites and targets

	before do
		  	@client = Fabricate(:client)
		  	@site = Fabricate(:site)
		  	@target = Fabricate(:target)
	end

	describe "Page of targets to contact" do

	  before do
	    visit targets_to_contact_path
	    # is it ok to make a route like that?
	  end

	  it "lists site.targets that haven't been contacted" do	    
	    # this is a line I need to work on.
	    page.should have_content(@site.targets.name.where(contacted == nil))

	  end

	  it "allows to mark target as contacted and removes from page" do
	    click_button "Contacted"
#  I think here I have to separate out into 2 tests
			page.reload
			# is there such a thing?
	    page.should_not have_content(@target.name)
	  end

	  it "records the date the site was contacted"
	  	click_button "Contacted"
	  	@site_target.contact eql Date.current 
		end

  end

  describe "Page of contacted targets" do
	    visit contacted_targets_path
	    # is it ok to make a route like that?
	  end

	  it "lists site.targets that have been contacted" do	    
	    page.should have_content(@site.targets.name.where 
	    	#  list of conditions
	    	contacted.exists && do_not_contact == nil && recontacted == nil && details_input == nil)
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