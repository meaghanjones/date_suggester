class DateIdea < ActiveRecord::Base
  has_and_belongs_to_many(:tags)
  validates(:name, {:presence => true, :length => { :maximum => 50}})
  before_save(:titlecase_name)

private

  def titlecase_name do
    self.name=(name.titlecase)
  end
end
