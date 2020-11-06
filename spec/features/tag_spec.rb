feature 'tags' do
    scenario 'A user adds a tag' do
      bookmark = Bookmark_Manager.add('Test link', 'http://www.test.com')
  
      visit '/bookmarks'
      first('.bookmark').click_button 'Add tag'
  
      expect(current_path).to eq "/bookmarks/#{bookmark.id}/tag/new"
      fill_in 'tag', with: 'Test tag'
      click_button 'Submit'
  
      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'Test tag'
    end
  end