class SessionsController < ApplicationController
  before_filter :login_required, :only=>:destroy
  def create
    user = auth(params[:login], params[:password])
    if user
      #logout_keeping_session!
      self.behance_session = user
      send_remember_cookie!
      render :text=>"behance_auth_session="+behance_session
    else
      access_denied
    end
    
  end
  
  def destroy
    logout_killing_session!
    render :text=>"logouted"
  end
  
end
