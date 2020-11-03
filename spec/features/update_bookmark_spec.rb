feature 'Updating a bookmark' do
  scenario 'A user can update a bookmark' do
    bookmark = Bookmark_Manager.add('Test link', 'http://www.test.com')
    visit '/bookmarks'
    expect(page).to have_link('Test link', href: 'http://www.test.com')

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'http://www.testedit.com')
    fill_in('title', with: "Test Edit")
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Test link', href: 'http://www.test.com')
    expect(page).to have_link('Test Edit', href: 'http://www.testedit.com')
  end
end