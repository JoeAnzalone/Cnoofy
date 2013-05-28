class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body

  attr_accessor :username

  has_many :blogs
  has_many :subscriptions
  has_many :subscribed_blogs, :through => :subscriptions, :source => :blog
  has_many :subscribed_posts, :through => :subscribed_blogs, :source => :posts
  after_create :create_user_blog
  
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
