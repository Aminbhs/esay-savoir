json.array! @formations do |formation|
  json.extract! formation, :id, :nom, :programme, :date_debut, :date_fin, :nombre_place_total, :nombre_place_restante
end
