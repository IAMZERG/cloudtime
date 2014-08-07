class ProjectsController < ApplicationController
	
	def new
		@projects = Project.all
	end
	
	def index
		@projects = Project.all
	end
	
	def create
		@project = Project.new(project_params)
		
		@project.save
		
		respond_to do |f|
			if @project.save
				## update the url passed to redirect_to as below
				f.html { redirect_to project_url(@project), notice: 'Project was successfully created.' }
				f.json { render action: 'show', status: :created, location: @project }
			else
				f.html { render action: 'new' }
				f.json { render json: @project.errors, status: :unprocessable_entity }
			end
		end
	end
	
	def edit
	end
	
	def show
		@project = Project.find(params[:id])
		@timeperiods = @project.timeperiods
	end
	
	private
		def project_params
			params.require(:project).permit(:description)
		end
end
