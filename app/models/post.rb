class Post < ActiveRecord::Base
  attr_accessible :type, :body, :title, :tag_list, :attachment, :remote_attachment_url, :url, :quote_source
  
  belongs_to :blog
  has_many :likes
  
  acts_as_taggable
  mount_uploader :attachment, AttachmentUploader

  # Disable single table inheritance
  self.inheritance_column = nil

  before_validation :smart_add_url_protocol

  def chat_html
    lines = '<div class="chat-content">'
    body.lines.each { |line|
      line.gsub!(/(.*):(.*)/) {"<span class=\"speaker\">#{$1}:</span> #{$2}"}
      lines += '<div class="line">' + line + '</div>'
    }
    lines += '</div>'
    lines.html_safe
  end

  def embed_code
    begin
      oembed_response = OEmbed::Providers.get(url)
      oembed_response.html.html_safe
    rescue
      'Sorry, no media found!'
    end
  end

  validate :require_photo_source, :unless => Proc.new { type != 'photo' }
  private
  def require_photo_source
    if attachment.blank? && remote_attachment_url.blank?
      errors.add(:base, "Please specify at least one image")
    end
  end

  # Prepend URLs with "http://" if they don't already include a protocol
  # http://stackoverflow.com/a/7908693
  protected
  def smart_add_url_protocol
    unless self.url.nil? || self.url[/^http:\/\//] || self.url[/^https:\/\//]
      self.url = 'http://' + self.url
    end
  end

end