require 'pg'
require_relative 'bookmark'

class Bookmark_Manager
  
  def self.all
    connection = self.connect_to_db
    result = connection.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])
    end
  end

  def self.add(title, link)
    connection = self.connect_to_db
    connection.exec("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{link}') RETURNING id, url, title;")
    true
  end

  def self.delete(link)
    connection = self.connect_to_db
    connection.exec("DELETE FROM bookmarks WHERE url = '#{link}';")
    true
  end

  private
  def self.connect_to_db
    if ENV['ENVIRONMENT'] == 'test'
      return PG.connect(dbname: 'bookmark_manager_test')
    else
      return PG.connect(dbname: 'bookmark_manager')
    end
  end

end

