require 'database_connection'

describe DatabaseConnection do
  describe '.setup' do
    it 'Sets up the correct database' do
      expect(PG).to receive(:connect).with(dbname: 'bookmark_manager_test')

      DatabaseConnection.setup('bookmark_manager_test')
    end

    it 'this connection is persistent' do
      database = DatabaseConnection.setup('bookmark_manager_test')
    
      expect(DatabaseConnection.database).to eq database
    end
  end

  describe '.query' do
    it 'executes a query via PG' do
      connection = DatabaseConnection.setup('bookmark_manager_test')

      expect(connection).to receive(:exec).with("SELECT * FROM bookmarks;")
      DatabaseConnection.query("SELECT * FROM bookmarks;")
    end
  end
end