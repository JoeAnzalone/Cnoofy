module BlogsHelper
  def blog_url(blog)
    root_url(:subdomain => blog.subdomain)
  end
end
