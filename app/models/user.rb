class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :roles

  attr_accessor :username

  ROLES = %w[admin moderator featured banned]

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }

  has_many :blogs
  has_many :subscriptions
  has_many :subscribed_blogs, :through => :subscriptions, :source => :blog

  after_create :create_user_blog
  
  def subscribed_posts
    blogs = [subscribed_blogs, self.blogs.first].flatten
    Post.find_all_by_blog_id( blogs, :order => "created_at DESC" ).flatten
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def add_role(role)
    self.roles = roles.push(role.to_s)
  end

  def remove_role(role)
    self.roles = roles - [role.to_s]
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def role?(role)
    roles.include? role.to_s
  end

  private
  def create_user_blog
    # build default profile instance. Will use default params.
    # The foreign key to the owning User model is set automatically
    build_blog
    true # Always return true in callbacks as the normal 'continue' state
         # Assumes that the default_profile can **always** be created.
         # or
         # Check the validation of the profile. If it is not valid, then
         # return false from the callback. Best to use a before_validation 
         # if doing this. View code should check the errors of the child.
         # Or add the child's errors to the User model's error array of the :base
         # error item
  end

  def build_blog
    b = self.blogs.create :subdomain => username, :title => "#{username}'s Blog", :description => 'Welcome to my blog!'
  end

end
