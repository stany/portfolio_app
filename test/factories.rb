require 'digest/sha1'

Factory.define :user do |u|
  u.login 'quentin'
  u.email {|a| "#{a.login}@example.com".downcase }
  u.salt {Digest::SHA1.hexdigest('0')}
  u.crypted_password {|a| User.password_digest('monkey', a.salt)}
  u.created_at {5.days.ago.to_s :db}
  u.remember_token_expires_at {1.days.from_now.to_s}
  u.remember_token {Digest::SHA1.hexdigest('1')}
  u.activated_at {5.days.ago.to_s :db}
  u.activation_code nil
end
