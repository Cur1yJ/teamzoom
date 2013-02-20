class CreateRequestInstalls < ActiveRecord::Migration
  def change
    create_table :request_installs do |t|

        t.string  :name
        t.string  :email
        t.string  :school
        t.string  :state
        t.string  :zip_code
        t.integer :phone
        t.string  :city
        t.string  :address
        t.string  :learnabout  
      

      t.timestamps
    end
  end
end
