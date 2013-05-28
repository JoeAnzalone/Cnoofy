# Adapted from http://asciicasts.com/episodes/221-subdomains-in-rails-3
module UrlHelper  
  
  def with_subdomain(subdomain)
    subdomain = (subdomain || "")
    subdomain += "." unless subdomain.empty?
    [subdomain, request.domain].join
  end

  def url_for(options = nil)
    if options.kind_of?(Hash) && options.has_key?(:subdomain)
      options[:host] = with_subdomain(options.delete(:subdomain))
    end
    super
  end

  def blog_url(blog)
    blog_front_url(:host => with_subdomain(blog.subdomain))
  end

end