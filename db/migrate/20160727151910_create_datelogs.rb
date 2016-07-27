class CreateDatelogs < ActiveRecord::Migration
  def change
    create_table(:datelogs) do |t|
      t.column(:romantic_interest, :string)
      t.column(:rendezvous_time, :datetime)
      t.column(:notes, :string)
      t.column(:date_idea_id, :integer)

      t.timestamps
    end
  end
end
