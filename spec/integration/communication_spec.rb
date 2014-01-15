# Does the name of the spec have to be the name of a model? Because I had it instead as the name of a 'functionality'
# These set of tests are about recording communications between sites and targets


# The point of this set of tests is to be able to create the following steps;
#  1. For each site there should be a page where there is a list of targets I have to contact. 
#  This should list only targets that haven't been contacted yet.

#  2. There should be another page that has a list of 'contacted' targets, and any target in that list
#  should have three options i) recontact (only once) ii) Do Not Contact iii) Input Details (which should 
#  redirect to the target page to put in details.



require 'spec_helper'

describe Site do 
# I wasn't sure if this was the class I should be testing, but I wanted to look at a site page, so that's why
# I did this one. I think I will be adding attributes like 'contacted', and 'do not contact' to the SiteTarget 
# model though, so should this be describing that model?

	describe "Page of targets to contact" do

	  before do
	  	@client = Fabricate(:client)
	  	@site = Fabricate(:site)
	  	@target = Fabricate(:target)
	    visit site_path
	  end

	  it "lists site.targets that haven't been contacted" do	    
	    page.should have_content(@target.name)
	  end

	  it "allows to mark target as contacted" do
	    click_button "Contacted"
#  I'm trying to figure out how to reload the page.
			page.reload
	    page.should_not have_content(@target.name)
	  end

	  it "records the date the site was contacted"
	  	click_button "Contacted"
	  	# @site_target.contact eql Date.current 
		end

  end


end