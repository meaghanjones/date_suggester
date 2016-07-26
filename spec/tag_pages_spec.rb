require('spec_helper')

describe 'Add a tag path', {:type => :feature} do
  it 'allows users to add a new tag to the database' do
    visit '/tags/new'
    fill_in 'tag_name', :with => 'Awesome'
    click_button 'Add Category'
    expect(page).to have_content('Awesome')
  end
  it 'allows users to view a list of tags' do
    Tag.create({:name => 'Awesome'})
    visit('/tags')
    expect(page).to have_content('Awesome')
  end
 end
