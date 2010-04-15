class CommentsController < ApplicationController
  before_filter :login_required, :only=>:update
  def index
    @project = Project.comments(getScraped(BehanceURL['gallery']+params[:name]+"/"+params[:id]), params[:id])
    respond_to do |format|
      format.xml do
        
      end
    end
  end
  
  def update
    postComment(params[:id], params[:comment])
    render :nothing=>true
  end
end
