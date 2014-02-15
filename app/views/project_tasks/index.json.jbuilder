json.array!(@project_tasks) do |project_task|
  json.extract! project_task, :id, :name
  json.url project_task_url(project_task, format: :json)
end
