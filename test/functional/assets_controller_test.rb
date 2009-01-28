require 'test_helper'

class AssetsControllerTest < ActionController::TestCase
  
  test "should upload photo" do
    photo = File.new(File.join(Rails.root, 'test', 'fixtures', '12k.png'))
    project = Factory(:project)
    login_and_set_host(project.user)
    assert_difference 'Asset.count' do
      post :create, {:project_id => project.to_param, :asset => {:photo => photo}}
      assert_redirected_to project_path(assigns(:project))
    end
  end

  test "should destory photo" do
    
  end
  
end
