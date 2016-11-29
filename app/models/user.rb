class User < ApplicationRecord
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :concerts

  has_secure_password
end