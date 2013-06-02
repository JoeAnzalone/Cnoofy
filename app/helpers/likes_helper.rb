module LikesHelper
  def like_button(post)

    return unless current_user.present?

    if current_user.likes.find_by_post_id(post)
      like_display   = :none
      unlike_display = :inline
    else
      like_display   = :inline
      unlike_display = :none
    end

    link_to('Like', like_path(post), :method => :put, :remote => true, :class => 'like-unlike like', :style => "display: #{like_display};") +
    link_to('Unlike', unlike_path(post), :method => :delete, :remote => true, :class => 'like-unlike unlike', :style => "display: #{unlike_display};")
    
  end
end