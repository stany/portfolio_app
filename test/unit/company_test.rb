require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < ActiveSupport::TestCase
  
  test "should validate company with only url" do
    company = Factory.build(:company, :name => nil)
    assert company.valid?
    assert_nil company.errors.on(:name)
  end
  
  test "should validate company with name only" do
    company = Factory.build(:company, :url => nil)
    assert company.valid?
    assert_nil company.errors.on(:url)
  end
  
  test "should validate url format" do
    ["www.qqq.de", "http://www.qqq.", "http://qype"].each do |url|
      company = Factory.build(:company, :url => url)
      assert !company.valid?
      assert company.errors.on(:url)  
    end
    ["http://www.qqq.de", "http://www.qqq.co.uk", "http://qype.gov"].each do |url|
      company = Factory.build(:company, :url => url)
      assert company.valid?
      assert_nil company.errors.on(:url)  
    end
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
