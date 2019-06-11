class User<ActiveRecord::Base
  has_many :tweets
  has_secure_password
  
  def slug
    username = self.username
    slug_name = username.strip.downcase.gsub(" ", "-")
  end
  
  def self.find_by_slug(slug_name)
    self.all.detect {|i| i.slug == slug_name}
  end
end