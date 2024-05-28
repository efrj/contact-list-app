class Contact < ApplicationRecord
  belongs_to :user
  
  validates :name, :cpf, :phone, :address, :city, :state, :zip, presence: true
  validates :cpf, uniqueness: { scope: :user_id }, cpf: true
end
