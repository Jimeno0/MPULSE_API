class Concert < ApplicationRecord
  has_and_belongs_to_many :users

  validates :concert_id, presence: true, uniqueness: true
  
end