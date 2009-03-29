require File.dirname(__FILE__) + '/../test_helper'

class PagesControllerTest < ActionController::TestCase

  test "Should show home page" do
    get :show, :id => 'home'
    assert_response :success
  end

end