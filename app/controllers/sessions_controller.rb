class SessionsController < ApplicationController
	def create
		auth = request.env['omniauth.auth']
    if auth and params[:provider]
      @authhash = Hash.new # {"email" => '', "name" => '', "uid" =>'',  "provider" =>''}
			@authhash[:provider] = auth['provider'] or ''
    	if params[:provider] == 'facebook'
				@authhash[:email] = auth['extra']['raw_info']['email'] or ''
				@authhash[:name] =  auth['extra']['raw_info']['name'] or ''
				@authhash[:uid] =  auth['extra']['raw_info']['id'].to_s or ''
				@authhash[:fb_token] = auth['credentials']['token'] or nil
			elsif ['google'].index(params[:provider]) != nil
				@authhash[:email] =  auth['info']['email'] or ''
				@authhash[:name] = auth['info']['name'] or ''
				@authhash[:uid] = auth['uid'].to_s or ''
			else
				# TODO: message that it is not supported
				render root_url
				return
			end

			if @authhash[:uid] != '' and @authhash[:provider] != ''
            @auth_service = AuthService.find_by_uid(@authhash[:uid])
            if signed_in?
                if @auth_service   # To make sure that the auth we found is for currently logged in user
                    if @auth_service.user == current_user
                    else
                      reset_session
                      current_user = @auth_service.user
                    end
                else
                end
            else
              reset_session
							if @auth_service
                	self.current_user = @auth_service.user
              else
                  @user = User.create
                  @user.email = @authhash[:email]
                  @user.name = @authhash[:name]
                  @user.fbid = @authhash[:fb_token]
                  @user.uid = @authhash[:uid]
                  @user.provider = @authhash[:provider]
                  session[:uid] = @authhash[:uid]
                  session[:user_id] = @user.id
                  if @user.save
                    @auth_i = AuthService.create
                    @auth_i.uemail = @authhash[:email]
                    @auth_i.uname = @authhash[:name]
                    @auth_i.user_id = @user.id
                    @auth_i.uid = @authhash[:uid]
                    @auth_i.provider = @authhash[:provider]
                    @auth_i.save
                  end
             end
				end
			  @authhash[:fb_token] && session[:fb_token] = @authhash[:fb_token]
      end
      @users_terms = User.find_by_uid(@authhash[:uid])
      if @users_terms.terms == false
        I18n.locale = @users_terms.locale
        redirect_to :action => "terms" ,:controller => "users"
      else
        I18n.locale = @users_terms.locale
        redirect_to :action => "show" ,:controller => "users", :id => session[:user_id]
      end
		end
	end

	def signout
		logger.debug "token:", session[:fb_token]
		if session[:fb_token]
		  #TODO: ask a user if he wants to logout from fb as well?
      url = "https://www.facebook.com/logout.php?access_token=" + session[:fb_token] + "&next=" + root_url
      reset_session
      logger.debug url
      redirect_to url
    else
      #url = "https://mail.google.com/mail/u/0/?logout&hl=en&continue=" + root_url
      url = "https://www.google.com/accounts/logout?continue=" + root_url
      reset_session
      redirect_to url
    end
  end

	private
	def reset_session
	  self.current_user = nil
    session[:fb_token] = nil
	end
end
