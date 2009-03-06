require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase

  test "should validate attributes" do
    post = Factory.build(:post, :user => nil, :title => nil, :content => nil)
    assert !post.valid?
    assert post.errors.on(:user)
    assert post.errors.on(:title)
    assert post.errors.on(:content)
  end

  test "should create" do
    post = Factory(:post)
    assert post.valid?
    assert !post.new_record?
  end
  
  test "should have tags" do
    post = Factory(:post)
    post.tag_list = "first, second, third"
    post.save
    
    assert 3, post.tags.size
    assert Post.tagged_with('first', :on => :tags).include?(post)
  end
  
end
