require('spec_helper')

describe(Tag) do
  it('validates presence of tag name') do
    tag = Tag.new({:name => ''})
    expect(tag.save).to(eq(false))
  end
end
