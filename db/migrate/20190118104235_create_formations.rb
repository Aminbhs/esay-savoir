class CreateFormations < ActiveRecord::Migration[5.1]
  def change
    create_table :formations do |t|
      t.string :nom
      t.string :programme
      t.date :date_debut
      t.date :date_fin
      t.integer :nombre_place_total
      t.integer :nombre_place_restante

      t.timestamps
    end
  end
end
