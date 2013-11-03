class SitesController < ApplicationController

  before_filter :find_client

	def new 
		@site = @client.sites.build
	end

  def create
    @site = @client.sites.build(site_params)
    #@site.client = Client.find(params[:client_id]) if params[:client_id]
    @site.save ? redirect_to(client_site_path(@site.client, @site), notice: "Site '#{@site.name}' created successfully.") : render(:new)
  end

  def show 
    @site = @client.sites.find(params[:id])
  end

 private

  def site_params
    params.require(:site).permit(:name, :url, :client_id)
  end

  def find_client
    @client = Client.find(params[:client_id])
  end
end
