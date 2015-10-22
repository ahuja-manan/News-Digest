#
# This class is a modified version 
# of the User class written by Mat Blair
# for the Workshop 2 (Wordgram) solution
#
class User < ActiveRecord::Base
	# Validations
 	validates_presence_of :email, :first_name, :last_name, :username
  	validates :email, format: { with: /(.+)@(.+).[a-z]{2,4}/, message: "%{value} is not a valid email" }
  	validates :username, length: { minimum: 3 }

	# Users can have interests
	acts_as_taggable_on :interests

	# Use secure passwords
	has_secure_password
   

	# Find a user by email, then check the username is the same
	def self.authenticate password, username
		user = User.find_by(username: username)
		if user && user.authenticate(password)
			return user
		else
			return nil
		end
	end

	def full_name
		first_name + ' ' + last_name
	end
end
