require 'spec_helper'

describe "Site Show Page" do 

	before do
		@site = Fabricate(:site)
		@new_target = Fabricate(:target)
		Fabricate(:site_target, site: @site, target: @new_target)
		@contacted_target = Fabricate(:target)
		Fabricate(:contacted_site_target, site: @site, target: @contacted_target)
	end

	describe "Div of uncontacted targets" do

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

  describe "Div of contacted targets" do

  	before do
	    visit client_site_path(@site.client, @site)		
		end

	  it "lists site.targets that have been contacted in the targets contacted section" do
	  	within(".targets.contacted") do
	    	page.should have_content(@contacted_target.name)
	    	page.should_not have_content(@new_target.name)
	  	end
		end 

# None of these tests are

	  it "allows to choose recontact as a dropdown once but never again" do
	  	select("Recontacted")
	  	click_button "Update Targets"
	    page.should_not have_select("Recontacted")	
	    within(".status") do
	    	page.should have_content("Recontacted")
	    end 
	    # this is obviously not even a real thing!
	  end

		it "allows to choose 'Do Not Contact' as a dropdown and writes that as it's status" do
	  	select("Do Not Contact")
	  	click_button "Update Targets"
	    within(".status") do
	    	page.should have_content("Do Not Contact")
	    end
	    # this page has that content in the drop down all the time!!!
	  end

	  it "allows to choose Input Details as a dropdown and redirects to target page" do
	  	select("Input Details")
	  	click_button "Update Targets"
			# then we want this to redirect to the site-target page, is that possible?
			# then I manually went to that page, which is ridiculous, because of course then it would pass!
	    page.should have_content("Enter Offer Details")
	  end
  end
end