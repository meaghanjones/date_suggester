class Datelog < ActiveRecord::Base
  belongs_to(:date_idea)
  validates(:rendezvous_time, :presence => true)
end
