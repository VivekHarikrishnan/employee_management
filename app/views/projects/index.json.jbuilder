json.array!(@projects) do |project|
  json.extract! project, :id, :name, :client, :type
  json.url project_url(project, format: :json)
end
