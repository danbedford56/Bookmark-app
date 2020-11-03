feature 'Adding a new bookmark' do
  scenario 'A user can add a bookmark to Bookmark Manager' do
    visit('/bookmarks/new')
    fill_in('title', with: 'Test bookmark')
    fill_in('url', with: 'http://www.test.com')
    click_button 'Submit'

    expect(page).to have_content 'Test bookmark'
  end
end