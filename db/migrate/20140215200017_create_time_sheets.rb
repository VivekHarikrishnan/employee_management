class CreateTimeSheets < ActiveRecord::Migration
  def change
    create_table :time_sheets do |t|
      t.integer :employees_projects_id
      t.integer :project_task_id
      t.date :date_of_sheet
      t.time :from_time
      t.time :to_time

      t.timestamps
    end
  end
end
