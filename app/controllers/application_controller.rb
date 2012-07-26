class ApplicationController < ActionController::Base
  rescue_from Exception, :with => :render_404
  protect_from_forgery
  helper_method :current_user, :signed_in?
  before_filter :set_locale
  def set_locale
     I18n.locale = params[:locale] ||  I18n.default_locale
      @userlanguage = User.find_by_id(session[:user_id])
       if session[:user_id].present?
        I18n.locale = params[:locale] || @userlanguage.locale ||  I18n.default_locale
          if params[:locale] and @userlanguage
             @userlanguage.locale=params[:locale]
             @userlanguage.save
          end
       end
  end
  def current_user
		@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
	end

	def signed_in?
		!!current_user
	end

	def current_user=(user)
		@current_user = user
		session[:user_id] = user.nil? ? user : user.id
	end

  def logged_in?
    return (session[:user_id].to_i > 0)
  end

  def set_user

    begin
      if @user.nil? && session[:user_id]

        @user = User.find_by_id(session[:user_id])

        if @user.nil?
          return
        end

      end
    rescue  Exception => e

    end
  end
unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from ActionController::UnknownAction, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

end

private
def extract_locale_from_accept_language_header
  request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
end

def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'error/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end