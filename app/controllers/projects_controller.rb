class ProjectsController < ApplicationController
  
  def index
    params[:id]||=''
    params[:global_category]||='featured'
    @projects = Project.all(getScraped(BehanceURL[params[:global_category]]+params[:id]), params[:global_category])
    respond_to do |format|
      format.xml do
        @logged_in = logged_in?
      end
      format.html do
        render :text=>behance_session
      end
    end
  end
  
  
  def show
    @project = Project.one(getScraped(BehanceURL['gallery']+params[:name]+"/"+params[:id]), params[:name]+"/"+params[:id])
    respond_to do |format|
      format.xml do
        
      end
    end
  end
  
  def search
    @projects = Project.all(getScraped(BehanceURL['search']+params[:search_for]))
    respond_to do |format|
      format.xml do
        render :action=>"index"
      end
    end
  end
  
end
