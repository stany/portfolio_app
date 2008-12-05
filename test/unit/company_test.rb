require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < ActiveSupport::TestCase
  
  test "should validate attributes" do
    company = Factory.build(:company, :name => nil)
    assert !company.valid?
    assert company.errors.on(:name)
  end
  
  test "should create" do
    company = Factory.build(:company)
    assert company.save
  end
  
  test "should have many projects" do
    company = Factory(:company)
    Factory(:project, :company => company, :title => 'First project', :user => Factory(:user, :login => 'first'))
    Factory(:project, :company => company, :title => 'Second project', :user => Factory(:user, :login => 'second'))
    assert_equal 2, company.projects.count
  end
end
