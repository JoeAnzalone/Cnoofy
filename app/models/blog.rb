class Blog < ActiveRecord::Base
  attr_accessible :description, :subdomain, :title

  has_many :posts
  belongs_to :user

end
