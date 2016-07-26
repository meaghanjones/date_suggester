class CreateDateIdeasTags < ActiveRecord::Migration
  def change
    create_table(:date_ideas_tags) do |t|
      t.column(:date_idea_id, :integer)
      t.column(:tag_id, :integer)

      t.timestamps
    end
  end
end
