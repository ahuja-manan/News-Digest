# Defines User model 
class User < ActiveRecord::Base
  # Converts attribute mailed_articles from text to Array
  serialize :mailed_articles,Array

  # Validations
  validates_presence_of :email, :first_name, :last_name, :username
  
  # prevents user to enter multiple emails, and an email of incorrect format
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	
  validates :username, :length => { minimum: 3 }
  validates_uniqueness_of :username
  
  validates :password, length: { minimum: 8, message: "must be greater than 7 characters" }, :on => :create
  validates :password, :length => { minimum: 8, message: "must be greater than 7 characters" }, :allow_blank => true, :on => :update

  # Users have an interest list
  acts_as_taggable_on :interests
 
  # Passwords are stored as a hash in the database
  has_secure_password

  # Find a user by username, then verify their password
  def self.authenticate password, username
    user = User.find_by(username: username)
	  if user && user.authenticate(password)
	    return user
	  else
		return nil
	  end
  end

  # Return the user's full name
  def full_name
	first_name + ' ' + last_name
  end

end
