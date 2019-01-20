json.array! @clients do |client|
  json.extract! client, :id, :nom, :prenom, :nom_rue, :rue, :codepostal, :ville, :telephone :email
end
