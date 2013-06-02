module LikesHelper

  def like_button(post)

    if !user_signed_in? || current_user.likes.find_by_post_id(post).nil?
      link_to "Like", likes_path(:post_id => post), :method => :post, :class => 'like'
    else
      like = current_user.likes.find_by_post_id(post)
      link_to "Unlike", like, :confirm => 'Are you sure?', :method => :delete, :class => 'unlike'
    end
    
  end

end