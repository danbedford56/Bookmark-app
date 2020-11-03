require 'bookmark_manager'

RSpec.describe Bookmark_Manager do

  describe '.all' do
    it "Returns all of the user's bookmarks" do
      Bookmark_Manager.add("Test", "http://www.google.com")
      bookmarks = Bookmark_Manager.all
      expect(bookmarks.first.url).to eq("http://www.google.com")
    end
  end

  describe '.add' do
    it 'Adds a new bookmark to the database' do
      expect(Bookmark_Manager.add("Test", "http://www.google.com")).to eq true
    end
  end

  describe '.delete' do
    it 'Adds a new bookmark to the database' do
      Bookmark_Manager.add("Test", "http://www.google.com")
      expect(Bookmark_Manager.delete("http://www.google.com")).to eq true
    end
  end

  
end
