class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :update_last_seen
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = '*'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def broadcast_server
      if request.port.to_i != 80
        "http://my-faye-server.herokuapp.com:80/faye"
      else
        "http://my-faye-server.herokuapp.com/faye"
      end            
  end
  helper_method :broadcast_server

  def broadcast_message(channel, data)
    message = { :ext => {:auth_token => FAYE_TOKEN}, :channel => channel, :data => data}
    uri = URI.parse(broadcast_server)
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
  
	def update_last_seen
    unless current_user == nil
		  current_user.last_seen = DateTime.now
     	current_user.save
	  end
	end
  
end
