json.array!(@jobs) do |job|
  json.id job.id
  json.title job.title
  json.description job.description
  json.status job.status
  json.skills job.skills
end
