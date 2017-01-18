require 'bcrypt'

class User < ActiveRecord::Base
  



  # BCrypt and Authentication
  def password
    @password ||= BCrypt::Password.new(hashed_password) # hangs on to the plain text password and compares it against the entered plain text password for authentication
  end

  def password=(plain_text_new_password)
    @password = BCrypt::Password.create(plain_text_new_password) # this transforms a new, plain text password into a hashed password
    self.hashed_password = @password # stores the hashed password in the database within the 'hashed_password' column of the 'users' table
  end

  def authenticate(plain_text_password)
    # 'self.password' below calls the 'password' getter method above
    # '==' below is BCrypt's special version of '=='
    self.password == plain_text_password
  end

end