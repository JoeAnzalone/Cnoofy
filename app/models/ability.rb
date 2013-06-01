class Ability
  include CanCan::Ability

  def initialize(user)
        
    unless user 
      can :read, :all
      can :show_posts, Blog
    else
      # All registered users
      
      can :read, :all
      can :show_posts, Blog

      # can :create, Comment
      # can :update, Comment do |comment|
        # comment.try(:user) == user || user.role?(:moderator)
      # end

      can :create, Blog

      can [:create, :like, :unlike], Post
      can :create, Subscription

      can :manage, Blog do |blog|
        blog.try(:user) == user
      end

      can :manage, Post do |post|
        post.try(:blog).try(:user) == user
      end

      can :manage, Subscription do |subscription|
        subscription.try(:user) == user
      end

      if user.role? :moderator
        can :manage, Blog
        can :manage, Post
        # can :manage, Comment
      end

      # Admins 
      if user.role? :admin
        can :manage, :all
      end

    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
