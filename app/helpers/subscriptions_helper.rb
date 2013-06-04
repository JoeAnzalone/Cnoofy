module SubscriptionsHelper

  def follow_button(blog)
    
    if ( user_signed_in? && current_user.blogs.include?(blog) )
      return
    end

    if !current_user.present? || current_user.subscriptions.find_by_blog_id(blog).nil?
      follow_display   = 'inline-block'
      unfollow_display = :none
    else
      follow_display   = :none
      unfollow_display = 'inline-block'
    end

    link_to("Follow", follow_path(:blog_id => blog), :method => :put, :class => 'follow', :remote => true, :style => "display: #{follow_display};") +
    link_to("Unfollow", unfollow_path(:blog_id => blog), :confirm => 'Are you sure?', :method => :delete, :class => 'unfollow', :remote => true, :style => "display: #{unfollow_display};")
    
  end

end