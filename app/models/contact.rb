class Contact < ApplicationRecord
  belongs_to :user
  
  validates :name, :cpf, :phone, :address, :city, :state, :zip, presence: true
  validates :cpf, uniqueness: { scope: :user_id }, cpf: true

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  def full_address
    "#{address}, #{city}, #{state}, #{zip}"
  end
end
