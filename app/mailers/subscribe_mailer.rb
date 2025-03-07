class SubscribeMailer < ApplicationMailer
  default from:  Rails.application.credentials.dig(:email, :user_name) # pega o email com base no arquivo criptografado

  def bem_vindo(usuario)
    @usuario = usuario
    mail(to: @usuario.email, subject: 'Bem-vindo ao nosso site!')
  end
end
