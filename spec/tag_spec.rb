require('spec_helper')

describe(Tag) do
  it('validates presence of tag name') do
    tag = Tag.new({:name => ''})
    expect(tag.save).to(eq(false))
  end
  it('validates the length of the tag is less than 20 characters') do
    tag = Tag.create(:name => 'a'.*(21))
    expect(tag.save).to(eq(false))
  end
  it('belongs to a date')do
    date_idea = DateIdea.create({:name => 'Duck Pond'})
    tag = date_idea.tags().new({:name => 'Casual'})
    expect(date_idea.tags()).to(eq([tag]))
  end
  describe('Tag#titlecase_tag_name') do
    it('converts the tag name to title case') do
      tag = Tag.create({:name => 'super romantic' })
      expect(tag.name).to(eq('Super Romantic'))
    end
  end
end
