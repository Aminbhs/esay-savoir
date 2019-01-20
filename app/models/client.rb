class Client < ApplicationRecord
  has_many :reservations
  has_many :formations, through: :reservations

end
