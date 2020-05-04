class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

def slug
  slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  slug
end

def self.find_by_slug(slug)
  user = self.all.select {|user| user.slug == slug }
  user[0]
end


end
