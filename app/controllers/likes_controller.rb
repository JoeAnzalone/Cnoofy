class LikesController < ApplicationController
  load_and_authorize_resource

  def index
    @likes = current_user.likes
  end

  def create
    @like = current_user.likes.build(:post_id => params[:post_id])

    if @like.save
    respond_to do |format|
      format.json { render json: @post }
      format.html { redirect_to likes_url, :notice => "Successfully liked." }
    end
    else
      render :action => 'new'
    end
  end

  def destroy
    @like = current_user.likes.find_by_post_id(params[:post_id])
    @like.destroy
    respond_to do |format|
      format.json { render json: @post }
      format.html { redirect_to likes_url, :notice => "Successfully unliked." }
    end
  end
end