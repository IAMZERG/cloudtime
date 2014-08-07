class TimeperiodsController < ApplicationController	
	#much if not all of the code in these controller methods are adapted from:
	#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/

	def new
		@projects = Project.all
		@project = Project.find(params[:project_id])
		@timeperiods = @project.timeperiods.build
	end
	
	def index
		@project = Project.find(params[:project_id])
		@timeperiods = @project.timeperiods
	end
	
	def show
		@project = Project.find(params[:project_id])
		@timeperiods = @project.timeperiods
	end
	
	def create

		project = Project.find(params[:project_id])

		@timeperiod = project.timeperiods.create(params[:id])

		respond_to do |format|
		if @timeperiod.save
		
				format.html { redirect_to([@timeperiod.project, @project], :notice => 'Timeperiod was successfully created.') }

				format.xml  { render :xml => @timeperiod, :status => :created, :location => [@project.timeperiod, @timeperiod] }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @timeperiod.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	def edit
		project = Project.find(params[:project_id])
		@timeperiod = project.timeperiods.find(params[:id])
		
	end
	
	def update
		#much if not all of the code in these controller methods are adapted from:
		#http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/
		#1st you retrieve the project thanks to params[:project_id]
		project = Project.find(params[:project_id])
		#2nd you retrieve the timeperiod thanks to params[:id]
		@timeperiod = project.timeperiods.find(params[:id])

		respond_to do |format|
			if @timeperiod.update_attributes(timeperiod_params)  
			#spent 2-3 hrs. gettin above line right. timeperiod_params, not params[timeperiod_params]... DOH!
				#1st argument of redirect_to is an array, in order to build the correct route to the nested resource timeperiod
				format.html { redirect_to([@timeperiod.project, @timeperiod], :notice => 'Timeperiod was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @timeperiod.errors, :status => :unprocessable_entity }
			end
		end
	end

	private

	def timeperiod_params
		params.require(:timeperiod).permit(:note, :updated_at, :created_at)
	end

end
