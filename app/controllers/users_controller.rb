class UsersController < ApplicationController
  
  def show
    @user = User.one(getScraped(BehanceDomain+"/"+params[:id]), params[:id])
    respond_to do |format|
      format.xml do
        
      end
    end
  end
  
end
