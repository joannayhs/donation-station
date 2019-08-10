class CreateCharitiesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :charities do |t|
      t.string :name
      t.text :description 
    end 
  end
end
