class SubscriptionsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!

  def index
    @subscriptions = current_user.subscriptions
  end

  def create
    @subscription = current_user.subscriptions.build(:blog_id => params[:blog_id])

    if @subscription.save
      redirect_to subscriptions_url, :notice => "Successfully followed."
    else
      render :action => 'new'
    end
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_url, :notice => "Successfully unfollowed."
  end
end