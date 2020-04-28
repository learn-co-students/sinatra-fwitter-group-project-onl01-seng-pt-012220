class User < ActiveRecord::Base
  include Slugafiable::InstanceMethods
  extend Slugafiable::ClassMethods
  has_secure_password
  has_many :tweets
  validates :username, :email, :password, presence: true
end
