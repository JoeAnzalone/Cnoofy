class Post < ActiveRecord::Base
  attr_accessible :type, :body, :title, :tag_list, :url, :quote_source
  belongs_to :blog
  acts_as_taggable

  # Disable single table inheritance
  self.inheritance_column = nil

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
end