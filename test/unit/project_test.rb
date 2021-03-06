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

  test "should save new company" do
    project = Factory.build(:project, :company => nil)
    project.company_attributes = {:name => 'New Company'}
    project.save!
    assert_equal 'New Company', project.reload.company.name
  end

  test "should edit company" do
    project = Factory(:project)
    project.company_attributes = {:name => 'Yahoo Inc.'}
    project.save!
    assert_equal 'Yahoo Inc.', project.reload.company.name
  end

  test "can belong to company" do
    company = Factory(:company)
    project = Factory(:project, :company => company)
    assert_equal company, project.reload.company
  end

  test "should have tags" do
    project = Factory(:project)
    project.tag_list = "first, second, third"
    project.save
    
    assert 3, project.tags.size
    assert Project.tagged_with('first', :on => :tags).include?(project)
  end

end
