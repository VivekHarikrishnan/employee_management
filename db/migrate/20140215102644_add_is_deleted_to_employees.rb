class AddIsDeletedToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :is_deleted, :boolean, :default => false
  end
end
