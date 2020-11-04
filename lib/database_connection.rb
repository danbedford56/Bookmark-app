require 'pg'

class DatabaseConnection
  @database

  def self.setup(dbname)
    @database = PG.connect(dbname: dbname)
  end

  def self.query(query)
    @database.exec(query)
  end

  def self.database
    return @database
  end

end
