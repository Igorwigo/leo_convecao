class PagesController < ApplicationController
  def home
    @schedule_data = [
      {
        date: "01/05/2025",
        dayName: "Dia 1",
        events: [
          {
            time: "12 ás 16",
            title: "Toca do Leão",
            description: "Momento para conexões",
          },
          {
            time: "20:00",
            title: "Plenária",
            description: "Plenária",
          },
          {
            time: "20:00",
            title: "Abertura oficial",
            description: "Abertura oficial",
          },
          {
            time: "20:00",
            title: "Jantar",
            description: "Jantar",
          },
        ]
      },
      {
        date: "02/05/2025",
        dayName: "Dia 2",
        events: [
          {
            time: "--",
            title: "Programação Surpresa",
            description: "Programação Surpresa",
          },
        ]
      },
      {
        date: "03/05/2025",
        dayName: "Dia 3",
        events: [
          {
            time: "08:00",
            title: "Plenária Convenção",
            description: "Plenária Convenção",
          },
          {
            time: "20:00",
            title: "Festa de Encerramento",
            description: "Festa de Encerramento",
          },
        ]
      }
    ]
  end

  def redirect_url
    # params = params
    params = request.filtered_parameters
    if params.present?
      params_id = params["external_reference"]
      @registration = Registration.find(params_id)

      if params['collection_status'] == 'approved'
        @registration.update(status: params['collection_status'], message: "Sua inscrição foi confirmada, Nos vemos no evento companheiro! 🎉")
      end


      # payment_query(params)
    end
  end

  private

  def payment_query(params)
    if params['collection_status'] == 'approved'
      @registration.update(status: params['collection_status'], message: "Sua inscrição foi confirmada, Nos vemos no evento companheiro! 🎉")
    end





    # sdk = Mercadopago::SDK.new(Rails.application.credentials.dig(:mercadopago, :access_token))
    # response = sdk.payment.get(params["payment_id"])
    #
    # if response[:status] == 200
    #   payment_info = response[:response]["status"]
    #   if payment_info.to_sym == :approved
    #     puts "Detalhes do Pagamento: #{payment_info}"
    #     @registration.update(status: payment_info, message: "Sua inscrição foi confirmada, Nos vemos no evento companheiro! 🎉")
    #     # Aqui você pode salvar no banco ou tratar de acordo com seu sistema
    #   end
    # end
    # if @registration.mercado_pago_retorno.present?
    #   @registration.mercado_pago_retorno.update(payment_id: params["payment_id"],
    #                                             raw_response: response )
    # end
  end

  def search_preference
    sdk = Mercadopago::SDK.new(Rails.application.credentials.dig(:mercadopago, :access_token))
    # Define os parâmetros da pesquisa
    filters = { external_reference: 1 }

    # Realiza a busca
    search_result = sdk.merchant_order.search(filters: filters)

  end
end