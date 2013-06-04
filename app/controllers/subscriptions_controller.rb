class SubscriptionsController < ApplicationController
  load_and_authorize_resource

  def index
    @subscriptions = current_user.subscriptions.order("created_at DESC")
  end

  def create
    @subscription = current_user.subscriptions.build(:blog_id => params[:blog_id])

    if @subscription.save
    respond_to do |format|
      format.json { render json: @subscription }
      format.html { redirect_to subscriptions_url, :notice => "Successfully followed." }
    end
    else
      render :action => 'new'
    end
  end

  def destroy
    @subscription = current_user.subscriptions.find_by_blog_id(params[:blog_id])
    @subscription.destroy
    respond_to do |format|
      format.json { render json: @subscription }
      format.html { redirect_to subscriptions_url, :notice => "Successfully unfollowed." }
    end
  end
end