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

	  it "lists site.targets that haven't been contacted in the new targets section" do
	  	within(".targets.uncontacted") do
	    	page.should have_content(@new_target.name)
	    	page.should_not have_content(@contacted_target.name)
	  	end
	  end

		describe "updating targets as contacted" do

			before do
				@current = DateTime.current
				Timecop.freeze(@current)
				check @new_target.name
	    	click_button "Update Targets"
			end

			after do
				Timecop.return
			end

	  	it "allows to mark target as contacted and moves to contacted section" do
	  		within(".targets.uncontacted") do
					page.should_not have_content(@new_target.name)
				end
	  	end

	  	it "moves to contacted section and displays the date the site was contacted" do
	  		within(".targets.contacted") do
					page.should have_content(@new_target.name)
					page.should have_content(DateTime.current.to_s(:long))
				end
			end
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