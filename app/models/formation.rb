class Formation < ApplicationRecord
  has_many :reservations
  has_many :clients, through: :reservations

  validates :nom, presence: true
  validates :programme, presence: true
  validates :date_debut, presence: true
  validates :date_fin, presence: true
  validates :nombre_place_total, presence: true
  validates :nombre_place_restante, presence: true
end
