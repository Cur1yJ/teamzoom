class CreateSchoolRequests < ActiveRecord::Migration
  def change
    create_table :school_requests do |t|
      
        t.string  :state
        t.string  :school 
        t.timestamps
    end
  end
end
