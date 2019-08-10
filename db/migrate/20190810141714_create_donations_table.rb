class CreateDonationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.float :amount 
      t.datetime :date 
    end 
  end 
end
