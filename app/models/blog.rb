class Blog < ActiveRecord::Base
  attr_accessible :description, :subdomain, :title, :attachment

  has_many :posts
  has_many :subscriptions
  belongs_to :user

  mount_uploader :attachment, AttachmentUploader

  before_create :lowercase_subdomain
  
  def avatar(options = {:size => 50})
    if self.attachment_url
      version = 'square_' + options[:size].to_s
      img_url = self.attachment_url(version).to_s
    else
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      img_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{options[:size]}&d=monsterid"
    end
    ApplicationController.helpers.image_tag img_url
  end

  private
  def lowercase_subdomain
    self.subdomain.downcase!
  end

end