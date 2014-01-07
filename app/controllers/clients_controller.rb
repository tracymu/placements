class ClientsController < ApplicationController

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.save ? redirect_to(client_path(@client), notice: "Client '#{@client.name}' created successfully.") : render(:new)
  end

  def show
    @client = Client.find(params[:id])
  end

  private

  def client_params
    params.require(:client).permit(:name)
  end
end
