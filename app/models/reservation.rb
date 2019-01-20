class Reservation < ApplicationRecord
  belongs_to :formation
  belongs_to :client
  validate :verify_place
  validate :verify_dispo

  after_create :remove_place
  before_destroy :add_place

  def verify_place
    #verifi si il des places de libre
    unless self.formation.nombre_place_total > self.formation.nombre_place_restante && self.formation.nombre_place_restante > 0
      errors.add(:base, "Plus de place" )
    end
  end

  def verify_dispo

    unless self.client == nil #Dans le cas ou le client n'existe pas

      nbr_formation_at_same_time = self.client.formations.where(date_debut: self.formation.date_debut..self.formation.date_fin).or(self.client.formations.where(date_fin: self.formation.date_debut..self.formation.date_fin)).count
      unless nbr_formation_at_same_time < 1 # Verifi si le nombre de formation ayant une date de début ou de fin compris entre le debut et la fin de la formation.
        errors.add(:base, "Déjà une formation à ce moment" )
      end
    end
  end

  def remove_place
    #Enleve une place de disponible lorsqu'un user a reservé un cours.
    self.formation.update(nombre_place_restante: (self.formation.nombre_place_restante - 1))
  end

  def add_place
    self.formation.update(nombre_place_restante: (self.formation.nombre_place_restante + 1))
  end

end
