class ChangeColumnExperienceInEmployees < ActiveRecord::Migration
  def change
  	change_column :employees, :experience, :decimal, :precision => 10, :scale => 2
  end
end
