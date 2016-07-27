require('spec_helper')

describe 'Add a tag path', {:type => :feature} do
  it 'allows users to add a new tag to the database' do
    visit '/dates/new'
    fill_in 'tag_name', :with => 'Awesome'
    click_button 'Add Category'
    expect(page).to have_content('Awesome')
  end
  it 'allows users to view a list of tags' do
    Tag.create({:name => 'Awesome'})
    visit('/tags')
    expect(page).to have_content('Awesome')
  end
  it 'allows users to view a list of dates for each tag' do
    tag = Tag.create({:name => 'Awesome'})
    tag.date_ideas.create({:name => 'County Fair'})
    visit '/tags'
    click_link 'Awesome'
    expect(page).to have_content('County Fair')
  end
 end
