require_relative 'database_connection'
class Tag

    attr_reader :id, :content

    def initialize(id:, content:)
        @id = id
        @content= content
    end

    def self.create(content:)
        result = DatabaseConnection.query("SELECT * FROM tags WHERE content = '#{content}';").first
        if !result
            result = DatabaseConnection.query("INSERT INTO tags (content) VALUES ('#{content}') RETURNING id, content;").first
        end
        Tag.new(
            id: result[0]['id'],
            content: result[0]['content'],
        )
    end

    def self.where(bookmark_id:)
        result = DatabaseConnection.query("SELECT id, content FROM bookmark_tags INNER JOIN tags ON tags.id = bookmark_tags.tag_id WHERE bookmark_tags.bookmark.id = '#{bookmark_id}';")
        result.map do |tag|
            Tag.new(
                id: tag['id'],
                text: tag['content']
            )
        end
    end

    def self.find(tag_id:)
        result = DatabaseConnection.query("SELECT * FROM tags WHERE id = '#{tag_id}';")
        Tag.new(
            id: result[0]['id'],
            content: result[0]['content'],
        )
    end

end