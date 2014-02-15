class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :code
      t.string :name
      t.string :designation
      t.string :degree
      t.string :university
      t.string :college
      t.string :city
      t.decimal :experience
      t.text :address
      t.string :password_digest
      t.string :type

      t.timestamps
    end
  end
end
