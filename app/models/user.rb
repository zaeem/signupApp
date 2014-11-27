class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :identities

	def self.find_for_twitter_oauth(access_token, signed_in_resource=nil)
		puts '===='*100
		puts YAML::dump(access_token)
		puts '===='*100
    user = User.where(:email => access_token.uid + "@twitter.com").first
    if user
      identity = user.identities.where(:provider => access_token.provider).first
			if identity
				if access_token.extra.raw_info.name != user.name
					user.update_attributes(:name => access_token.extra.raw_info.name)
				end
			  return user
			else
				user1 = user.identities.create(name: access_token.extra.raw_info.name,
	      	provider: access_token.provider,
	    	)
	    	return user
			end
    else
      user = User.create(
	      email: access_token.uid + "@twitter.com",
	      name: access_token.extra.raw_info.name,
	      password: Devise.friendly_token[0,20],
	    )

	    user1 = user.identities.create(name: access_token.extra.raw_info.name,
	      provider:access_token.provider,
	    )
	    return user
    end
  end

  def self.connect_to_linkedin(access_token, signed_in_resource=nil)
  	puts '===='*100
		puts YAML::dump(access_token)
		puts '===='*100
    user = User.where(:email => access_token.info.email).first
    if user
    	identity = user.identities.where(:provider => access_token.provider).first
			if identity
				if access_token.info.first_name+" "+access_token.info.last_name != user.name
					user.update_attributes(:name => access_token.info.first_name+" "+access_token.info.last_name)
				end
			  return user
			else
				user1 = user.identities.create(name: access_token.info.first_name+" "+access_token.info.last_name,
	      	provider: access_token.provider,
	    	)
	    	return user
			end
		else
      user = User.create(
	      email: access_token.info.email,
	      name: access_token.info.first_name+" "+access_token.info.last_name,
	      password: Devise.friendly_token[0,20],
	    )

	    user1 = user.identities.create(name: access_token.info.first_name+" "+access_token.info.last_name,
	      provider:access_token.provider,
	    )
	    return user
		end
  end  

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  	puts '===='*100
		puts YAML::dump(access_token)
		puts '===='*100
    user = User.where(:email => access_token.info.email).first
    if user
    	identity = user.identities.where(:provider => access_token.provider).first
			if identity
				if access_token.extra.raw_info.name != user.name
					user.update_attributes(:name => access_token.extra.raw_info.name)
				end
			  return user
			else
				user1 = user.identities.create(name: access_token.extra.raw_info.name,
	      	provider: access_token.provider,
	    	)
	    	return user
			end
		else
      user = User.create(
	      email: access_token.info.email,
	      name: access_token.extra.raw_info.name,
	      password: Devise.friendly_token[0,20],
	    )

	    user1 = user.identities.create(name: access_token.extra.raw_info.name,
	      provider:access_token.provider,
	    )
	    return user
		end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
  	puts '===='*100
		puts YAML::dump(access_token)
		puts '===='*100
		data = access_token.info
		user = User.where(:email => data["email"]).first
		if user
			identity = user.identities.where(:provider => access_token.provider).first
			if identity
				if data["name"] != user.name
					user.update_attributes(:name => data["name"])
				end
			  return user
			else
				user1 = user.identities.create(name: data["name"],
	      	provider:access_token.provider,
	    	)
	    	return user
			end
		else
	  	user = User.create(
	      email: data["email"],
	      name: data["name"],
	      password: Devise.friendly_token[0,20],
	    )

	    user1 = user.identities.create(name: data["name"],
	      provider:access_token.provider,
	    )
	    return user
		end
	end 

end
