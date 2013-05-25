class Post < ActiveRecord::Base
  attr_accessible :body, :tags, :title, :url
  belongs_to :blog
end