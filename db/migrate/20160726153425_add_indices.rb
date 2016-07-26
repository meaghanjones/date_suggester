class AddIndices < ActiveRecord::Migration
  def change
    add_index :date_ideas_tags, :date_idea_id
    add_index :date_ideas_tags, :tag_id
    add_index :date_ideas, :rating
  end
end
