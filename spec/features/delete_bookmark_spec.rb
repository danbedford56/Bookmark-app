feature 'Deleting a bookmark' do
  scenario 'A user delete a bookmark' do
    Bookmark_Manager.add('Test Link', 'http://wwww.test.com')
    visit('/bookmarks')
    expect(page).to have_link('Test Link', href: 'http://wwww.test.com')

    first('.bookmark').click_button 'Delete'

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers Academy', href: 'http://www.makersacademy.com')
  end
end