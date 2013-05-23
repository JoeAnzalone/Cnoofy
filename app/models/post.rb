class Post < ActiveRecord::Base
  attr_accessible :body, :tags, :title
end
