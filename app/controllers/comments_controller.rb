class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.order("created_at DESC")
  end

  def new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user_id = current_user.id

    if @comment.save
    respond_to do |format|
      format.json { render json: @post }
      format.html { redirect_to blog_post_path(@post.blog, @post), :notice => "Successfully saved." }
    end
    else
      render :action => 'new'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:post_id])
    @comment.destroy
    respond_to do |format|
      format.json { render json: @post }
      format.html { redirect_to blog_post_path(@post.blog, @post), :notice => "Successfully deleted comment." }
    end
  end
end