require 'spec_helper'

describe DateIdea do
  it 'validates presence of name' do
    date_idea = DateIdea.new({:name => ''})
    expect(date_idea.save()).to(eq(false))
  end
  it 'validates length of name is less than 50 characters' do
    date_idea = DateIdea.create({:name => 'a'.*(51)})
    expect(date_idea.save()).to(eq(false))
  end
  it('belongs to a tag')do
    tag = Tag.create({:name => 'Romantic'})
    date_idea = tag.date_ideas().new({:name => 'Candle Lit Dinner'})
    expect(tag.date_ideas()).to(eq([date_idea]))
  end
  describe 'DateIdea#titlecase_name' do
      it 'converts the name of the date to title case' do
        date_idea = DateIdea.create({:name => 'bowling alley'})
        expect(date_idea.name()).to(eq('Bowling Alley'))
      end
  end
end
