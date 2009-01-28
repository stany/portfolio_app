require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  test "should redirect to root if subdomain doesn't exist" do
    host! "bad.test"
    get :index
    assert_redirected_to root_url(:subdomain => false)
  end

  test "should get index" do
    login_and_set_host

    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    login_and_set_host
    get :new
    assert_response :success
  end

  test "should create project" do
    login_and_set_host
    assert_difference('Project.count') do
      post :create, :project => { :title => "Test", :description => "test", :started_on => Time.now.to_s(:db) }
    end

    assert_redirected_to projects_url
  end

  test "should get show" do
    project = Factory(:project)
    login_and_set_host(project.user)
    get :show, :id => project.to_param
    assert_response :success
    assert assigns(:project)
  end

  test "should get edit" do
    project = Factory(:project)
    login_and_set_host(project.user)
    get :edit, :id => project.to_param
    assert_response :success
    assert assigns(:project)
  end

  test "should update project" do
    project = Factory(:project)
    login_and_set_host(project.user)
    put :update, :id => project.to_param, :project => { }
    assert_redirected_to projects_url
  end

  test "should destroy project" do
    project = Factory(:project)
    login_and_set_host(project.user)
    assert_difference('Project.count', -1) do
      delete :destroy, :id => project.to_param
    end

    assert_redirected_to projects_path
  end
  
  test "should post tags" do
    login_and_set_host
    post :create, :project => { :title => "Test", :description => "test", :started_on => Time.now.to_s(:db), :tag_list => 'first, second, third'}
    assert_redirected_to projects_url
    assert_equal 3, Project.last.tags.size
  end
  
  test "should update tags" do
    project = Factory(:project, :tag_list => 'one')
    login_and_set_host(project.user)
    put :update, {:id => project.to_param, :project => {:tag_list => 'one, two, three'}}
    assert_redirected_to projects_path
    assert_equal 3, project.reload.tags.size
  end
  
end
