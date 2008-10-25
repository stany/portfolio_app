require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def test_should_validate_attributes
    project = Factory.build(:project, :user => nil, :title => nil, :description => nil, :started_on => nil)
    assert !project.valid?
    assert project.errors.on(:user)
    assert project.errors.on(:title)
    assert project.errors.on(:description)
    assert project.errors.on(:started_on)
  end

  def test_should_create
    project = Factory(:project)
    assert project.valid?
    assert !project.new_record?
  end


end
