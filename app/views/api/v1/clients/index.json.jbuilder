json.array! @clients do |client|
  json.extract! client, :id, :nom, :prenom, :num_rue, :rue, :codepostal, :ville, :telephone :email
end
