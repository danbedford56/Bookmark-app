require 'comment'
require 'bookmark_manager'

describe Comment do
  describe '.create' do
    it 'Creates a new comment' do
      bookmark = Bookmark_Manager.add('Test link', 'http://www.test.com')
      comment = Comment.create(text: 'Test comment', bookmark_id: bookmark.id)

      expect(comment).to be_a Comment
      expect(comment.text).to eq 'Test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end

  describe '.where' do
    it 'gets the relevant comments from the database' do
      bookmark = Bookmark_Manager.add('Test link', 'http://www.test.com')
      Comment.create(text: 'test comment', bookmark_id: bookmark.id)
      Comment.create(text: 'test comment 2', bookmark_id: bookmark.id)

      comments = Comment.where(bookmark_id: bookmark.id)
      comment = comments.first

      expect(comments.length).to eq 2
      expect(comment.text).to eq 'test comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
end