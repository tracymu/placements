# The point of this set of tests is to be able to create the following steps;
#  1. On the site page, there should be a list of targets, and if I have contacted those targets, 
# I should be able to click a 'contacted' button, to record that.
#  2. On the site page, there should  be a list of 'contacted' targets, and any target in that list
#  should have three options i) recontact (only once) ii) Do Not Contact iii) Input Details


require 'spec_helper'

describe Site do
      
	describe "Mark as contacted" do

	  before do
	  	@client = Fabricate(:client)
	  	@site = Fabricate(:site)
	  	@target = Fabricate(:target)
	    visit site_path
	  end

	  it "lists site_targets" do	    
	    page.should have_content(@target.name)
	  end

	  it "allows to mark as contacted" do
	    click_button "Contacted"
	    page.should_not have_content(@site.name)
	    # I don't really no if can do 'should_not' so I am going to look into this
	  end
  end
end