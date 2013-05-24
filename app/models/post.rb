class Post < ActiveRecord::Base
  attr_accessible :body, :tags, :title
  belongs_to :blog
end
