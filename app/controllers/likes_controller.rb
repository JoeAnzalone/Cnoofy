class LikesController < ApplicationController
  load_and_authorize_resource

  def index
    @likes = current_user.likes
  end

  def create
    @like = current_user.likes.build(:post_id => params[:post_id])

    if @like.save
      redirect_to likes_url, :notice => "Successfully liked."
    else
      render :action => 'new'
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_to likes_url, :notice => "Successfully unliked."
  end
end