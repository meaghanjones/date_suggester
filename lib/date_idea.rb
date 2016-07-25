class DateIdea < ActiveRecord::Base
  validates(:name, :presence => true)
end
