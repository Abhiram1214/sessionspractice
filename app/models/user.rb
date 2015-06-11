require 'digest/sha1'

class User < ActiveRecord::Base


attr_accessor :password, :password_confirmation

  def password=(pass)
    @password = pass

    self.salt = User.random_met(10)
    self.hashedpassword = User.encrypt(@password, self.salt)
  end

  def self.encrypt(pass,salt)
    Digest::SHA1.hexdigest(pass+salt)
  end

  def self.authenticate(login, pass)
    user_auth = User.find(:first, :conditions=>["login = ?", login])
    return nil if user_auth.nil?
     return user_auth if User.encrypt(pass,user_auth.salt)==user_auth.hashedpassword     
  end

  def self.random_met(len)
    char = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    salted = ""
    1.upto(len) { |i| salted << char[rand(char.size-1)] }
    return salted
  end

end
