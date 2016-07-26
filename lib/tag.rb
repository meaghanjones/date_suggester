class Tag < ActiveRecord::Base
  validates(:name, {:presence => true, :length => {:maximum => 20}})
  before_save(:titlecase_tag_name)

private

  def titlecase_tag_name do
    self.name=(name.titlecase)
  end
end
