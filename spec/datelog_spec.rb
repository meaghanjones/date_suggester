require 'spec_helper'

describe Datelog do
  it 'validates presence of rendezvous_time' do
    datelog = Datelog.create({:rendezvous_time => ''})
    expect(datelog.save).to(eq(false))
  end
  it 'belongs to a date_idea' do
    date_idea = DateIdea.create({:name => 'Candle Lit Dinner'})
    datelog = date_idea.datelogs.create({:rendezvous_time => Time.new, :romantic_interest => 'Fluffy'})
    expect(date_idea.datelogs).to(eq([datelog]))
  end
end
