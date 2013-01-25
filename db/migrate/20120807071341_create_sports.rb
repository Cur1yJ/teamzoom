class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :name
      t.string :description
      t.string :imgage

      t.timestamps
    end
  end
end
