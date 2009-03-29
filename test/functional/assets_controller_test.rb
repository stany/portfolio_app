require 'test_helper'

class AssetsControllerTest < ActionController::TestCase
  
  test "should upload photo" do
    photo = File.new(File.join(Rails.root, 'test', 'fixtures', '12k.png'))
    project = Factory(:project)
    login_as(project.user)
    assert_difference 'Asset.count' do
      post :create, :project_id => project.to_param, :asset => {:photo => photo}, :user_id => project.user.to_param
      assert_response 200
    end
  end

end
