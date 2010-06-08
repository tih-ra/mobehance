module Behance
  BehanceDomain = "http://www.behance.net/"
  BehanceURL = {"featured"=>BehanceDomain+"?content=projects&sort=featured_date&time=all&page=1&url=&sort_order=desc", 
                "recent"=>BehanceDomain+"?content=projects&sort=published_date&time=all&page=1&sort_order=desc",
                "week_viewed"=>BehanceDomain+"?content=projects&sort=views&time=week&page=1&url=",
                "signin"=>BehanceDomain+"index.php/auth/loginSubmit",
                "post_comment"=>BehanceDomain+"index.php/project/postComment",
                "gallery"=>BehanceDomain+"gallery/",
                "search"=>BehanceDomain+"?search=",
                "realms"=>BehanceDomain+"?field=",
                "users"=>BehanceDomain}
  
  protected
  def getScraped url, sufix=nil
    Nokogiri::HTML(logged_in? ? open(sufix.nil? ? url : url+sufix, "Cookie" => behance_session ) : open(sufix.nil? ? url : url+sufix))
  end
  
  def postComment proj_id, comment
    url = URI.parse(BehanceURL['post_comment'])
    http = Net::HTTP.new(url.host, url.port)
    
    data = "proj_id="+proj_id+"&comment="+comment+""
    
    headers = {
          'Cookie' => behance_session
        }
    res = http.post(url.path, data, headers) 
    case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        "Good"
      else
        res.error!
      end
    #proj_id, comment
  end
  
  def behance_session
    @behance_session ||= (login_from_basic_auth || login_from_cookie) unless @behance_session == false
  end
  
  def behance_session=(session)
    @behance_session = session
  end
  
  def logged_in?
    !!behance_session
  end
  
  def authorized?(action = action_name, resource = nil)
    logged_in?
  end
  
  def auth email, password
    res = Net::HTTP.post_form(URI.parse(BehanceURL['signin']), {:email=>email, :password=>password})
    
    if (JSON.parse(res.body)['valid']=='yes')
      return res.header['set-cookie']
      #@behance_session = res.header['set-cookie']
      #cookies[:behance_auth_session] = @behance_session
      #send_remember_cookie!
    end
    return false
  end
  
  def login_required
    authorized? || access_denied
  end

  
  def access_denied
    #respond_to do |format|
      
      #format.html do
        #store_location
        #redirect_to new_session_path
      #end
      
      #format.any(:json, :xml) do
        request_http_basic_authentication 'Web Password'
      #end
    #end
  end
  
  def login_from_basic_auth
    authenticate_with_http_basic do |login, password|
      self.auth login, password
    end
  end
  
  def login_from_cookie
    session = cookies[:behance_auth_session]
    if session
      @behance_session = session
    end
  end
  
  
  def logout_keeping_session!
    @behance_session = false
    kill_remember_cookie!     # Kill client-side auth cookie
   
  end

  def logout_killing_session!
    logout_keeping_session!
    reset_session
  end
  
  def kill_remember_cookie!
    cookies.delete :behance_auth_session
  end
  
  def send_remember_cookie!
    
    cookies[:behance_auth_session] = {
      :value   => @behance_session,
      :expires => 3.hours.from_now }
  end
end