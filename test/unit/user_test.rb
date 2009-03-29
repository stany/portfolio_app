require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper

  

  def test_should_create_user
    assert_difference 'User.count' do
      user = Factory(:user)
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_login
    assert_no_difference 'User.count' do
      u = Factory.build(:user, :login => nil)
      assert !u.valid?
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = Factory.build(:user, :password => nil, :crypted_password => nil)
      assert !u.valid?
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = Factory.build(:user, :password_confirmation => nil, :crypted_password => nil)
      assert !u.valid?
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = Factory.build(:user, :email => nil)
      assert !u.valid?
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    user = Factory(:user)
    user.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal user, User.authenticate(user.login, 'new password')
  end

  def test_should_not_rehash_password
    user = Factory(:user)
    user.update_attributes(:login => 'quentin2')
    assert_equal user, User.authenticate('quentin2', 'monkey')
  end

  def test_should_authenticate_user
    user = Factory(:user)
    assert_equal user, User.authenticate(user.login, 'monkey')
  end

  def test_should_set_remember_token
    user = Factory(:user)
    user.remember_me
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
  end

  def test_should_unset_remember_token
    user = Factory(:user)
    user.remember_me
    assert_not_nil user.remember_token
    user.forget_me
    assert_nil user.remember_token
  end

  def test_should_remember_me_for_one_week
    user = Factory(:user)
    before = 1.week.from_now.utc
    user.remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
    assert user.remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    user = Factory(:user)
    time = 1.week.from_now.utc
    user.remember_me_until time
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
    assert_equal user.remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    user = Factory(:user)
    before = 2.weeks.from_now.utc
    user.remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil user.remember_token
    assert_not_nil user.remember_token_expires_at
    assert user.remember_token_expires_at.between?(before, after)
  end

end
