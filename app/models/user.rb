require 'sha1'

class User < ActiveRecord::Base
  validates_uniqueness_of :name_key, :password

  def self.hash_of_text(text)
    SHA1::hexdigest("#{text}-UserSalt")
  end

  def self.signup!(params)
    params = params.dup
    params[:name_key] = params[:legal_name].downcase.gsub(/\W/, "")
    raise UserSignupException, "password must be at least 8 characters long" unless params[:password].length >= 8
    raise UserSignupException, "passwords don't match" unless params[:password] == params[:password_verified]
    raise UserSignupException, "password must contain both uppercase and lowercase letters" unless params[:password] =~ /([a-z].*[A-Z]|[A-Z].*[a-z])/
    raise UserSignupException, "invalid email format" unless params[:email] =~ /\w[\w_\.-]*@[\w_]+(\.[\w_]+)+/i
    params.delete(:password_verified)
    params[:password] = hash_of_text(params[:password])
    begin
      return create!(params)
    rescue ActiveRecord::RecordInvalid, "Validation failed: Password has already been taken, Legal name has already been taken"
      raise UserSignupException, "there is already a user with that name/password combination"
    end
  end
end

class UserSignupException < Exception
end
