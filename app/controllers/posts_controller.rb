class PostsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!, :except => [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    if ( request[:blog_id] ) then
      @blog  = Blog.find(request[:blog_id])
      @posts = @blog.posts.order("created_at DESC")
      @title = "#{@blog.subdomain}'s Posts"
    elsif ( request[:tag] ) then
      @title = "Posts tagged '#{params[:tag]}'"
      @posts = Post.tagged_with(params[:tag]).order("created_at DESC")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  def following
    @title = 'Dashboard'
    @posts = current_user.subscribed_posts
    @blog = current_user.blogs.first
    respond_to do |format|
      format.html { render 'index' }
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @blog = Blog.find_by_subdomain(request.subdomain) || Blog.find(params[:blog_id])
    @post = @blog.posts.find(params[:id])

    respond_to do |format|
      format.html { render :layout => 'blog' }
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @post.type = params[:type]
    @blog = current_user.blogs.first
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @blog = @post.blog
  end

  # POST /posts
  # POST /posts.json
  def create
    @blog = Blog.find(params[:blog_id])
    @post = Post.new(params[:post])    
    @post.blog_id = @blog.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to blog_post_path(@blog, @post), notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @blog = @post.blog
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to [@blog, @post], notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to blog_posts_url, notice: 'Post was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def like
    @post = Post.find(params[:post_id])
    current_user.likes << @post
    respond_to do |format|
      format.html { redirect_to blog_post_path(@post.blog, @post), notice: 'Post was successfully liked.' }
      format.json { render json: @post }
    end
  end

  def unlike
    @post = Post.find(params[:post_id])
    current_user.likes.delete(@post)
    respond_to do |format|
      format.html { redirect_to blog_post_path(@post.blog, @post), notice: 'Post was successfully unliked.' }
      format.json { render json: @post }
    end
  end
end