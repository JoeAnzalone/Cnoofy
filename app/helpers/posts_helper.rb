module PostsHelper
  def permalink(post)
    post_url(post, :subdomain => post.blog.subdomain)
  end
end