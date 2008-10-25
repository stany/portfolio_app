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
end

# aaron:
#   id:                        2
#   login:                     aaron
#   email:                     aaron@example.com
#   salt:                      da4b9237bacccdf19c0760cab7aec4a8359010b0 # SHA1('1')
#   crypted_password:          42d6f4429d7297fdc42498ff838e2ef3dee8ed22 # 'monkey'
#   created_at:                <%= 1.days.ago.to_s :db %>
#   remember_token_expires_at: 
#   remember_token:            
#   activation_code:           1b6453892473a467d07372d45eb05abc2031647a
#   activated_at:              
# 
# 
# old_password_holder:
#   id:                        3
#   login:                     old_password_holder
#   email:                     salty_dog@example.com
#   salt:                      7e3041ebc2fc05a40c60028e2c4901a81035d3cd
#   crypted_password:          00742970dc9e6319f8019fd54864d3ea740f04b1 # test
#   created_at:                <%= 1.days.ago.to_s :db %>
# 
#   activation_code:           
#   activated_at:              <%= 5.days.ago.to_s :db %>
# 
# 
