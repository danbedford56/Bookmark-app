require_relative 'bookmark'
require_relative 'database_connection'
require_relative 'comment'

class Bookmark_Manager
  
  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(bookmark['id'], bookmark['title'], bookmark['url'])
    end
  end

  def self.add(title, link)
    result = DatabaseConnection.query("INSERT INTO bookmarks (title, url) VALUES ('#{title}', '#{link}') RETURNING id, url, title;")
    Bookmark.new(result[0]['id'], title, link)
  end

  def self.delete(id)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = '#{id}';")
    true
  end

  def self.update(id:, title:, url:)
    DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id} RETURNING id, url, title;")
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

end

