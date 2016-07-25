require('spec_helper')

describe 'Add a date path', {:type => :feature} do
  it 'allows users to add a new date to the database' do
    visit '/'
    click_link 'Add a New Date'
    fill_in 'name', :with => 'Ikea'
    fill_in 'street', :with => '10280 NE Cascades Parkway'
    fill_in 'city', :with => 'Portland'
    fill_in 'state', :with => 'OR'
    fill_in 'description', :with => 'Eat meatballs and sit on couches!'
    click_button 'Add Date'
    expect(page).to have_content('Ikea')
  end

  it('allows users to view a list of dates') do
   DateIdea.create({:name => 'Ikea'})
   visit('/dates')
   expect(page).to have_content('Ikea')
 end
end
