class DateIdea < ActiveRecord::Base
  validates(:name, {:presence => true, :length => { :maximum => 50}})
  before_save(:titlecase_name)

private

  define_method(:titlecase_name) do
    self.name=(name.titlecase)
  end
end
