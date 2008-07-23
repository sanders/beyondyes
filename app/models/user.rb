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

  def self.signup!(params)
    return create!(params)
  end

  def validate_on_create
    self.name_key ||= User.name_key(legal_name)
    errors.add(:password, "is missing") unless password
    errors.add(:password, "must be at least 8 characters long") unless password.length >= 8
    errors.add(:password, "must contain both uppercase and lowercase letters") unless password =~ /([a-z].*[A-Z]|[A-Z].*[a-z])/
    errors.add(:password, "doesn't match verification password") unless password == password_verified
    self.password = User.hash_of_text(password)

    errors.add(:legal_name, "and password already taken") if User.find_by_legal_name_and_password(legal_name, password)
    errors.add(:legal_name, "and email already taken") if User.find_by_legal_name_and_email(legal_name, email)
    errors.add(:email, "invalid format") unless email =~ User.email_regexp
  end
end

class UserLoginException < Exception
end
