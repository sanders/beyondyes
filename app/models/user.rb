require 'sha1'

class User < ActiveRecord::Base
  def self.hash_of_text(text)
    SHA1::hexdigest("#{text}-UserSalt")
  end
end
