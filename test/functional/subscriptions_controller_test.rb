require 'test_helper'

class SubscriptionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_create_invalid
    Subscription.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Subscription.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to subscriptions_url
  end

  def test_destroy
    subscription = Subscription.first
    delete :destroy, :id => subscription
    assert_redirected_to subscriptions_url
    assert !Subscription.exists?(subscription.id)
  end
end
