class User < ApplicationRecord
  has_and_belongs_to_many :artists
  has_and_belongs_to_many :concerts

  has_secure_password

  has_secure_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 8 }

  def as_json(options={})
    super( only: [:name,:token])
  end
end