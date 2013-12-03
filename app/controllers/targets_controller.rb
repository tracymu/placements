class TargetsController < ApplicationController

	def new
		@target = Target.new
	end

	def create
		@target = Target.new(target_params)
		if @target.save
			redirect_to(target_path(@target), notice: "Target Site '#{@target.name}' Successfully Created")


		else
			render 'new'
		end

	end


	def show

		@target = Target.find(params[:id])

	end

	protected

	def target_params
		params.require(:target).permit(:name, :url, site_ids: [])
	end

end