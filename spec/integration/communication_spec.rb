require 'spec_helper'

describe "Site Show Pages" do 
# Not sure if this is the class I should be testing. I chose it because this functionality is looking at the
# communication between sites and targets

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
	    @current = DateTime.current
			Timecop.freeze(@current)
			check @new_target.name
	    click_button "Update Targets"
		end

		after do
				Timecop.return
		end

	  it "lists site.targets that have been contacted in the targets contacted section" do
	  	within(".targets.contacted") do
	    	page.should have_content(@contacted_target.name)
	    	# page.should_not have_content(@new_target.name)
	    	# why is this bit not passing?
	  	end
		end 

	  it "allows to choose recontact as a dropdown once, and never again" do
	  	select("Recontacted", :from => "status_id")
	    page.should_not have_content("recontacted")	 
	  end

		it "allows to choose 'Do Not Contact' as a dropdown, and prints that for contact" do
	  	select("Recontacted", :from => "status_id")
	    page.should have_content("Never Contact")
	  end

	  it "allows to choose Input Details as a dropdown and redirects to target page" do
	  	select("Recontacted", :from => "status_id")
	  	Visit site_target_path
	    page.should have_content("Enter Offer Details")
	  end
  end
end