feature 'Comments' do
  scenario 'A user adds a comment' do
    bookmark = Bookmark_Manager.add('Test link', 'http://www.test.com')

    visit '/bookmarks'
    first('.bookmark').click_button 'Add comment'

    expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"
    fill_in 'comment', with: 'Test comment'
    click_button 'Submit'

    expect(current_path).to eq '/bookmarks'
    expect(first('.bookmark')).to have_content 'Test comment'
  end
end