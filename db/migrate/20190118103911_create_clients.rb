class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :nom
      t.string :prenom
      t.string :num_rue
      t.string :rue
      t.string :codepostal
      t.string :ville
      t.string :telephone
      t.string :email

      t.timestamps
    end
  end
end
