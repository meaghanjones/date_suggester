require('spec_helper')

describe 'Add a date path', {:type => :feature} do
  it 'allows users to add a new date to the database' do
    Tag.create(:name => 'Casual')
    visit '/'
    click_link 'Add a New Date'
    fill_in 'name', :with => 'Ikea'
    fill_in 'street', :with => '10280 NE Cascades Parkway'
    fill_in 'city', :with => 'Portland'
    fill_in 'state', :with => 'OR'
    fill_in 'description', :with => 'Eat meatballs and sit on couches!'
    check 'Casual'
    click_button 'Add Date'
    expect(page).to have_content('Ikea')
  end

  it('allows users to view a list of dates') do
   DateIdea.create({:name => 'Ikea', :rating => 3})
   visit('/dates')
   expect(page).to have_content('Dates')
 end
 end

 describe 'Update a date path', {:type => :feature} do
  it'allows users to update date information' do
    DateIdea.create({:name => 'Ikea', :rating => 0})
    visit '/dates'
    click_link 'Ikea'
    click_link 'Edit Date'
    fill_in 'name', :with => 'Ikea Mega Store'
    click_button 'Edit Date'
    expect(page).to have_content'Ikea Mega Store'
  end
  it 'allows users to delete a date' do
    DateIdea.create({:name => 'Ikea', :rating => 0})
    visit '/dates'
    click_link 'Ikea'
    click_link 'Edit Date'
    click_button 'Delete Date'
    expect(page).to have_no_content('Ikea')
  end
end
