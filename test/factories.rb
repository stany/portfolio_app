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

Factory.define :company do |c|
  c.name "Google Inc."
  c.url "http://www.google.com"
end

Factory.define :project do |p|
  p.association :user, :factory => :user
  p.association :company, :factory => :company
  p.title 'Open Source Project'
  p.description 'Made the next big thing'
  p.url "http://mail.google.com"
  p.started_on { 1.year.ago.to_s :db }
  p.ended_on { 1.month.ago.to_s :db }
end


Factory.define :asset do |a|
  a.photo File.new(File.join(Rails.root, 'test', 'fixtures', '12k.png'))
  a.association :project, :factory => :project
end

