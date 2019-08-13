class CreateCharitiesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :charities do |t|
      t.string :name 
      t.string :description
      t.integer :user_id
      t.datetime :created_on
      t.datetime :updated_on
    end 
  end
end
