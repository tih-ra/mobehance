class ProjectsController < ApplicationController
  before_filter :get_host
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
    
    @project = Project.one(getScraped(BehanceURL['gallery']+params[:name]+"/"+params[:id]), params[:name]+"/"+params[:id], @my_host)
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
  
  def realms
    @projects = Project.all(getScraped(BehanceURL['search_by_realm']+params[:id]))
    respond_to do |format|
      format.xml do
        render :action=>"index"
      end
    end
  end
  
  private
  def get_host
    @my_host = request.env['HTTP_HOST']
  end
end
