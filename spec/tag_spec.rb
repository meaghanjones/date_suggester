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
  describe('Tag#titlecase_tag_name') do
    it('converts the tag name to title case') do
      tag = Tag.create({:name => 'super romantic' })
      expect(tag.name).to(eq('Super Romantic'))
    end
  end
end
