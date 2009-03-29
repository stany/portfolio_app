# Be sure to restart your server when you modify this file.
 
# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key => '_portfolio_app_session',
  :secret      => '220ebac5d9fed5a9aa53e2dcf797677923c00b9496db0834f77b0cdcdc72f6a1bc54e19fd348b32160361e7bcedf882897707439da2fad907ca8d0d3a5618646'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
ActionController::Dispatcher.middleware.use FlashSessionCookieMiddleware, ActionController::Base.session_options[:key]