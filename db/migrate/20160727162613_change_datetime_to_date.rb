class ChangeDatetimeToDate < ActiveRecord::Migration
  def change
    remove_column(:datelogs, :rendezvous_time, :datetime)
    add_column(:datelogs, :rendezvous_time, :date)
  end
end
