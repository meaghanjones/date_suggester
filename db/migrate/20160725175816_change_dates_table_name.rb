class ChangeDatesTableName < ActiveRecord::Migration
  def change
    rename_table :dates, :date_ideas
  end
end
