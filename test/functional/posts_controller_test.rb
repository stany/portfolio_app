require File.dirname(__FILE__) + '/../test_helper'

class PostsControllerTest < ActionController::TestCase

  test "should get index" do
    post = Factory(:post)
    get :index, {:user_id => post.user.to_param}
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    user = Factory(:user)
    login_as(user)
    get :new, {:user_id => user.to_param}
    assert_response :success
  end

  test "should create post" do
    user = Factory(:user)
    login_as(user)
    assert_difference('Post.count') do
      post :create, :user_id => user.to_param, :post => { :title => 'Blog post', :content => 'Blog content', :tag_list => 'first, second, third'}
    end
    assert_redirected_to post_path(assigns(:post))
    assert_equal 3, assigns(:post).tags.size
  end

  test "should show post" do
    post = Factory(:post)
    user = post.user
    login_as(user)
    get :show, :id => post.to_param, :user_id => user.to_param
    assert_response :success
    assert assigns(:post)
  end

  test "should get edit" do
    post = Factory(:post)
    user = post.user
    login_as(user)
    get :edit, :id => post.to_param, :user_id => user.to_param
    assert_response :success
    assert assigns(:post)
  end

  test "should update post" do
    post = Factory(:post)
    user = post.user
    login_as(user)
    put :update, :id => post.to_param, :post => { :tag_list => 'one, two, three' }, :user_id => user.to_param
    assert_redirected_to post_path(assigns(:post))
    assert_equal 3, assigns(:post).tags.size
  end

  test "should destroy post" do
    post = Factory(:post)
    user = post.user
    login_as(user)
    assert_difference('Post.count', -1) do
      delete :destroy, :id => post.to_param, :user_id => user.to_param
    end

    assert_redirected_to user_posts_path(user)
  end
  
end
