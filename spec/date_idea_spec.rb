require('spec_helper')

describe(DateIdea)do
  it('validates presence of name') do
    date_idea = DateIdea.new({:name => ''})
    expect(date_idea.save()).to(eq(false))
  end
end
