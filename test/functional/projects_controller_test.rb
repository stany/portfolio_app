require File.dirname(__FILE__) + '/../test_helper'

class ProjectsControllerTest < ActionController::TestCase

  test "should get index" do
    project = Factory(:project)
    get :index, {:user_id => project.user.to_param}
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new" do
    user = Factory(:user)
    login_as(user)
    get :new, {:user_id => user.to_param}
    assert_response :success
  end

  test "should create project" do
    user = Factory(:user)
    login_as(user)
    assert_difference('Project.count') do
      post :create, {:user_id => user.to_param, :project => { :title => "Test", :description => "test", :started_on => Time.now.to_s(:db), :tag_list => 'first, second, third'}}
    end

    assert_redirected_to user_projects_url(user)
    assert_equal 3, assigns(:project).tags.size
  end

  test "should get show" do
    project = Factory(:project)
    user = project.user
    login_as(user)
    get :show, {:user_id => user.to_param, :id => project.to_param}
    assert_response :success
    assert assigns(:project)
  end

  test "should get edit" do
    project = Factory(:project)
    user = project.user
    login_as(user)
    get :edit, {:id => project.to_param, :user_id => user.to_param}
    assert_response :success
    assert assigns(:project)
  end

  test "should update project" do
    project = Factory(:project)
    user = project.user
    login_as(user)
    put :update, :id => project.to_param, :project => {:tag_list => 'one, two, three'}, :user_id => user.to_param
    assert_redirected_to user_projects_url(user)
    assert_equal 3, assigns(:project).tags.size
  end

  test "should destroy project" do
    project = Factory(:project)
    user = project.user
    login_as(user)
    assert_difference('Project.count', -1) do
      delete :destroy, :id => project.to_param, :user_id => user.to_param
    end

    assert_redirected_to user_projects_path(user)
  end
  
  test "should get by tag" do
    project = Factory(:project, :tag_list => 'one')
    user = project.user
    login_as(user)
    get :tag, {:tag => 'one', :user_id => user.to_param}
    assert_response :success
    assert assigns(:projects).include?(project)
  end
  
end
