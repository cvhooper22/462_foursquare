class User < ActiveRecord::Base

	scope :by_foursquare_id, -> (id) { where({ foursquare_id: id }) }
	scope :by_username, -> (username) { where({username: username }) }
	
	def self.from_omniauth(omniauth_hash, username)
		info = omniauth_hash[:extra][:raw_info]
		user = find_or_create_by(username: username)
		user.foursquare_id = info[:id]
		user.first_name = info[:firstName]
		user.last_name = info[:lastName]
		user.email = info[:contact][:email]
		user.profile_url = info[:canonicalUrl]
		user.avatar_url = "#{info[:photo][:prefix]}#{info[:photo][:suffix]}"
		user.token = omniauth_hash[:credentials][:token]
		user.is_authorized = true
		user
	end
end
