class RegistrationsController < ApplicationController

  def create
    @registration = Registration.new(registration_params)

    if @registration.save
      Rails.logger.info "User #{@registration} salvo"
      # Gerar o QR Code Pix
      pix = QrcodePixRuby::Payload.new(
        pix_key:        'tesourariaconferencialeopmw@gmail.com',
        description:    "Pagamento inscricao#{@registration.id}",
        transaction_id: "TID#{@registration.id}",
        amount:         '290.00',
        currency:       '986',
        country_code:   'BR',
        repeatable:     false
      )
      @registration.update(
        copia_cola: pix.payload,
        qrcode: pix.base64 # Salva o QR Code Base64
      )

      @url_redirect = check_subscribe_registrations_path(email: @registration.email)
      # SubscribeMailer.bem_vindo(@registration).deliver_now

      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "registration_form",
            partial: "shared/registration_success"
          )
        }
        format.html { render partial: "shared/registration_success" } # Fallback para testes
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "registration_form",
            partial: "registrations/form",
          locals: { registration: @registration }
          )
        }
        format.html { render partial: "registrations/form" } # Fallback para testes
      end
    end
  end

  def check_subscribe
    @registrations = nil  # Inicializa como nil para evitar exibição na primeira visita
    @search_attempted = params[:q].present? || params[:email].present?  # Sinaliza se houve uma tentativa de busca
    if @search_attempted
      @registration = Registration.where("upper(email) like upper(?)", "%#{params[:q] || params[:email] }%").first
    else
      @registration = []
    end
    render :check_subscribe
  end

  private

  def registration_params
    params.require(:registration).permit(:name, :email, :phone, :club)
  end
end
