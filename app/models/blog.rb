class Blog < ActiveRecord::Base
  attr_accessible :description, :subdomain, :title
end
