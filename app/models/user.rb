class User < ApplicationRecord
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :concerts

  has_secure_password

  has_secure_token

  def as_json(options={})
    super( only: [:name,:token])
  end
end