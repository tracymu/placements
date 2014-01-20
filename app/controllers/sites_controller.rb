class SitesController < ApplicationController

  before_action :find_client
  before_action :find_site, only: [:show, :update]

	def new 
		@site = @client.sites.build
	end

  def create
    @site = @client.sites.build(site_params)
    @site.save ? redirect_to(client_site_path(@site.client, @site), notice: "Site '#{@site.name}' created successfully.") : render(:new)
  end

  def show
    @uncontacted_site_targets = @site.site_targets.uncontacted.includes(:target)
    @contacted_site_targets   = @site.site_targets.contacted.includes(:target)
  end

  def update
    target_ids = params[:targets].keys
    # I think I need to understand what this keys method actually does.
    uncontacted_site_targets = @site.site_targets.uncontacted.where(target_id: target_ids)
    contacted_at = DateTime.current
    uncontacted_site_targets.each do |uncontacted_site_target|
      uncontacted_site_target.update_attributes(contacted: contacted_at)
    end
    # I will have to add in a new loop here, where updating the status attribute
    redirect_to(client_site_path(@client, @site), notice: "Updated Targets Successfully")
  end

 private

  def site_params
    params.require(:site).permit(:name, :url, :client_id)
  end

  def find_client
    @client = Client.find(params[:client_id])
  end

  def find_site
    @site = @client.sites.find(params[:id])
  end
end
