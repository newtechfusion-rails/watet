class User < ActiveRecord::Base
        validates :email, :uniqueness => true
	has_many :products, :dependent => :destroy
	has_many :auth_services, :dependent => :destroy

	def self.create_with_omniauth(info)
		create(:name => info[:name])
	end
end
