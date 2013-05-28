module SubscriptionsHelper

  def follow_button(blog)    
    if !user_signed_in? || current_user.subscriptions.find_by_blog_id(blog).nil?
      link_to "Follow", subscriptions_path(:blog_id => blog), :method => :post, :class => 'follow'
    else
      subscription = current_user.subscriptions.find_by_blog_id(blog)
      link_to "Unfollow", subscription, :confirm => 'Are you sure?', :method => :delete, :class => 'unfollow'
    end
  end

end