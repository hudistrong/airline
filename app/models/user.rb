class User < ApplicationRecord
  include Clearance::User

  def self.authenticate(email, password)
    user = where(email: email).first
    user && user.authenticated?(password) ? user : nil
  end
end
