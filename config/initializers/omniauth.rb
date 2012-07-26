require 'openid/store/filesystem' 

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :facebook, '293967000701651', '294dc3d08e589374c47b5994994fcce9'
	provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
	# TODO: some of these below are not needed
	# provider :openid, :store => OpenID::Store::Filesystem.new('./tmp'), :name => 'openid'
	#provider :google, 'domain.com', 'oauth_secret', :scope => 'https://mail.google.com/mail/feed/atom/'
end

