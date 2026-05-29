class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum :role, { owner: 0, vet: 1, admin: 2 }
  validates :first_name, :last_name, presence: true

  has_one :owner
  has_one :vet
end