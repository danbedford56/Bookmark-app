require 'pg'
require './lib/database_connection'

def setup_test_database
  DatabaseConnection.setup('bookmark_manager_test')
  DatabaseConnection.query("TRUNCATE bookmarks CASCADE;")
end