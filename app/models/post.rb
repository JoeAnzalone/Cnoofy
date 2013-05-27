class Post < ActiveRecord::Base
  attr_accessible :type, :body, :title, :tag_list, :attachment, :remote_attachment_url, :url, :quote_source
  belongs_to :blog
  acts_as_taggable
  mount_uploader :attachment, AttachmentUploader

  # Disable single table inheritance
  self.inheritance_column = nil

  before_validation :smart_add_url_protocol

  def chat_lines
    body.lines
  end

  def chat_html
    lines = '<div class="chat-content">'
    chat_lines.each { |line|
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

  # Prepend URLs with "http://" if they don't already include a protocol
  # http://stackoverflow.com/a/7908693
  protected
  def smart_add_url_protocol
    unless self.url.nil? || self.url[/^http:\/\//] || self.url[/^https:\/\//]
      self.url = 'http://' + self.url
    end
  end

end