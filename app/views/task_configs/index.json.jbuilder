json.array!(@tasks) do |task|
  json.extract! task, :id, :finished_at, :status, :content
  json.url task_url(task, format: :json)
end
