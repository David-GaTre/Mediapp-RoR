Mailjet.configure do |config|
  config.api_key = '2191447cdd8375477feda4b870072c5c'
  config.secret_key = 'dc698fdc40ec63c8a0642aa1f4c01790'
  config.default_from = 'gtdavid2013@gmail.com'
  # Mailjet API v3.1 is at the moment limited to Send API.
  # We’ve not set the version to it directly since there is no other endpoint in that version.
  # We recommend you create a dedicated instance of the wrapper set with it to send your emails.
  # If you're only using the gem to send emails, then you can safely set it to this version.
  # Otherwise, you can remove the dedicated line into config/initializers/mailjet.rb.
end