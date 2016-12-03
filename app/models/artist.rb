class Artist < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: true

  def as_json(options={})
    super( only: [:name])
  end
end