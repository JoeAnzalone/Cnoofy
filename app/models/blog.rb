class Blog < ActiveRecord::Base
  attr_accessible :description, :subdomain, :title

  has_many :posts
  belongs_to :user

  before_create :lowercase_subdomain

  private
  def lowercase_subdomain
    self.subdomain.downcase!
  end

end
