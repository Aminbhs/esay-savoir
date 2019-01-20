json.array! @formations do |formation|
  json.extract! formation, :id,  :nom, :programme, :date_debut, :date_fin, :nombre_place_total, :nombre_place_restante
  json.clients formation.clients do |client|
    json.extract! client, :nom, :prenom, :num_rue, :rue, :codepostal, :ville, :telephone, :email
  end
end
