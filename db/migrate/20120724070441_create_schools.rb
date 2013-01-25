class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.references :conference
      t.timestamps
    end
    add_index :schools, :conference_id
  end
end
