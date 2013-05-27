class Blog < ActiveRecord::Base
  attr_accessible :description, :subdomain, :title, :attachment

  has_many :posts
  belongs_to :user

  mount_uploader :attachment, AttachmentUploader

  before_create :lowercase_subdomain

  def avatar(options = {:size => :square_50})
    if self.attachment_url
      img_url = self.attachment_url(options[:size]).to_s
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      img_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=50&d=monsterid"
    end
    ApplicationController.helpers.image_tag img_url
  end

  private
  def lowercase_subdomain
    self.subdomain.downcase!
  end

end