class User < ApplicationRecord
has_secure_password
attr_accessor :username, :email, :password, :password_confirmation
validate_uniqueness_of :username
end
