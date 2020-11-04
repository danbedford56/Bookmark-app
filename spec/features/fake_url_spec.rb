feature 'Fake URL detection' do
  scenario 'User enters invalid URL' do
    visit '/'
    fill_in :username, with: 'Dan'
    click_button 'Submit'
    click_link 'Add a new bookmark'
    fill_in('title', with: 'Fake URL')
    fill_in('url', with: 'Fake URL')
    click_button 'Submit'
    expect(current_path).to eq '/bookmarks/new'
    expect(page).to have_content 'This URL is not valid.'
  end
end