require 'sha1'

class User < ActiveRecord::Base
  attr_accessor :password_verified

  def self.hash_of_text(text)
    SHA1::hexdigest("#{text}-UserSalt")
  end

  def self.name_key(text)
    text.downcase.gsub(/\W/, "")
  end

  def self.email_regexp
    /\w[\w_\.-]*@[\w_]+(\.[\w_]+)+/i
  end

  def self.login(params)
    raise UserLoginException, "Password is missing" unless params[:password]
    raise UserLoginException, "Name/email is missing" unless params[:name_or_email]
    return User.find(:first, :conditions => ["password = ? and (email_key = ? or name_key = ?)",
      User.hash_of_text(params[:password]),
      User.name_key(params[:name_or_email]),
      User.name_key(params[:name_or_email])])
  end

  def self.signup!(params)
    return create!(params)
  end

  def validate_on_create
    self.name_key  ||= User.name_key(legal_name)
    self.email_key ||= User.name_key(email)
    errors.add(:password, "is missing") unless password
    errors.add(:password, "must be at least 8 characters long") unless password.length >= 8
    errors.add(:password, "must contain both uppercase and lowercase letters") unless password =~ /([a-z].*[A-Z]|[A-Z].*[a-z])/
    errors.add(:password, "doesn't match verification password") unless password == password_verified
    self.password = User.hash_of_text(password)

    errors.add(:legal_name, "and password already taken") if User.find_by_name_key_and_password(name_key, password)
    errors.add(:legal_name, "and email already taken") if User.find_by_name_key_and_email_key(name_key, email_key)
    errors.add(:email, "invalid format") unless email =~ User.email_regexp
  end
end

class UserLoginException < Exception
end
