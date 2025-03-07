class Registration < ApplicationRecord
  require 'mercadopago'
  attr_accessor :url_init_point

  #Relationships
  has_one :mercado_pago_retorno, dependent: :destroy

  #Validations
  validates :name, presence: true

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  #Callbacks

  def translate_status
    return if self.status.nil?
    status= self.status
    case status
    when 'pending'
      'Pendente!'
    when 'approved'
      'Aprovado!'
    end
  end
end