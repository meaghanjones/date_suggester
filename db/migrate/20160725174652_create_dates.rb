class CreateDates < ActiveRecord::Migration
  def change
    create_table (:dates) do |t|
      t.column(:name, :string)
      t.column(:address, :string)
      t.column(:description, :string)
      t.column(:rating, :integer)

      t.timestamps()
    end
  end
end
