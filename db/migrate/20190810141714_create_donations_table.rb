class CreateDonationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.string :charity
      t.decimal :amount 
      t.datetime :created_on
      t.integer :user_id
      t.integer :charity_id
    end 
  end 
end
