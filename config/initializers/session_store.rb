# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_mobehance_session',
  :secret => 'acdea7dc72f1767d41285672fda03d68b1fad889d4e5f49a2b454cdfae82d186134a96ab7033613d4c76081476b526743aff25ec0e2393bedbdd5013158827f1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
