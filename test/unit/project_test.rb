require File.dirname(__FILE__) + '/../test_helper'

class ProjectTest < ActiveSupport::TestCase

  test "should validate attributes" do
    project = Factory.build(:project, :user => nil, :title => nil, :description => nil, :started_on => nil)
    assert !project.valid?
    assert project.errors.on(:user)
    assert project.errors.on(:title)
    assert project.errors.on(:description)
    assert project.errors.on(:started_on)
  end

  test "should create" do
    project = Factory(:project)
    assert project.valid?
    assert !project.new_record?
  end

  test "should convert description to liquid template" do
    project = Factory(:project, :description => '*hello*')
    assert_equal '<p><strong>hello</strong></p>', project.description_view
  end

  test "can belong to company" do
    company = Factory(:company)
    project = Factory(:project, :company => company)
    assert_equal company, project.reload.company
  end

end
