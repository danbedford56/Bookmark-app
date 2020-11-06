require 'bookmark_manager'

RSpec.describe Bookmark_Manager do

  describe '.all' do
    it "Returns all of the user's bookmarks" do
      Bookmark_Manager.add("Test", "http://www.google.com")
      bookmarks = Bookmark_Manager.all
      expect(bookmarks.first.url).to eq("http://www.google.com")
    end
  end

  #describe '.add' do
    #it 'Adds a new bookmark to the database' do
     # expect(Bookmark_Manager.add("Test", "http://www.google.com")).to eq true
    #end
  #end

  describe '.delete' do
    it 'Adds a new bookmark to the database' do
      Bookmark_Manager.add("Test", "http://www.google.com")
      expect(Bookmark_Manager.delete("1")).to eq true
    end
  end

  let(:comment_class) { double(:comment_class) }

  describe 'comments' do
    it 'Returns a list of comments for the specified bookmark' do
      bookmark = Bookmark_Manager.add('Test', "http://www.test.com")
      DatabaseConnection.query("INSERT INTO comments (id, text, bookmark_id) VALUES(1, 'Test comment', #{bookmark.id})")

      comment = bookmark.comments.first
      expect(comment.text).to eq 'Test comment'
    end

    it 'calls .where on the Comment class' do
      bookmark = Bookmark_Manager.add("Test link", "http://www.test.com")
      expect(comment_class).to receive(:where).with(bookmark_id: bookmark.id)

      bookmark.comments(comment_class)
    end
  end
  
end
