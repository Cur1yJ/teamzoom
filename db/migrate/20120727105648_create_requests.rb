class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :state
      t.string :team

      t.timestamps
    end
  end
end
