class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  def slug
    slug = self.username
    slug.gsub(" ","-").downcase
  end

  def self.find_by_slug(slug)
    unslug = slug.gsub("-"," ")
    user = User.find_by_username(unslug)
  end

end
