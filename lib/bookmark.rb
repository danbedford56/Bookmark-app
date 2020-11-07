require_relative 'database_connection'
class Bookmark

  attr_reader :id, :title, :url

  def initialize(id, title, url)
    @id = id
    @title = title
    @url = url
  end

  def comments(comment_class = Comment)
    comment_class.where(bookmark_id: id)
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end
  
end