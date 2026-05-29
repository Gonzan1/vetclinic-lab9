class Vet < ApplicationRecord
  has_many :appointments
  belongs_to :user, optional: true
  
  # Callbacks
  before_validation :normalize_email

  # Scopes
  scope :by_specialization, ->(specialization) { where(specialization: specialization) }

  # Validations
  validates :first_name, :last_name, :specialization, :phone, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end