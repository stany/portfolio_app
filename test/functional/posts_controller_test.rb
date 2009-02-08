require File.dirname(__FILE__) + '/../test_helper'

class PostsControllerTest < ActionController::TestCase

  test "should redirect to root if subdomain doesn't exist" do
    host! "bad.test"
    get :index
    assert_redirected_to root_url(:subdomain => false)
  end

  test "should get index" do
    login_and_set_host
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    login_and_set_host
    get :new
    assert_response :success
  end

  test "should create post" do
    login_and_set_host
    assert_difference('Post.count') do
      post :create, :post => { :title => 'Blog post', :content => 'Blog content'}
    end

    assert_redirected_to post_path(assigns(:post))
  end

  test "should show post" do
    post = Factory(:post)
    login_and_set_host(post.user)
    get :show, :id => post.to_param
    assert_response :success
    assert assigns(:post)
  end

  test "should get edit" do
    post = Factory(:post)
    login_and_set_host(post.user)
    get :edit, :id => post.to_param
    assert_response :success
    assert assigns(:post)
  end

  test "should update post" do
    post = Factory(:post)
    login_and_set_host(post.user)
    put :update, :id => post.to_param, :post => { }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    post = Factory(:post)
    login_and_set_host(post.user)
    assert_difference('Post.count', -1) do
      delete :destroy, :id => post.to_param
    end

    assert_redirected_to posts_path
  end
  
  test "should post tags" do
    login_and_set_host
    post :create, :post => { :title => "Blog post", :content => "Blog content", :tag_list => 'first, second, third'}
    assert_redirected_to post_path(assigns(:post))
    assert_equal 3, Post.last.tags.size
  end
  
  test "should update tags" do
    post = Factory(:post, :tag_list => 'one')
    login_and_set_host(post.user)
    put :update, {:id => post.to_param, :post => {:tag_list => 'one, two, three'}}
    assert_redirected_to post_path(assigns(:post))
    assert_equal 3, post.reload.tags.size
  end
  
end
