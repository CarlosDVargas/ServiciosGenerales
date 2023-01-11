class RequestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.new_request.subject
  #
  def new_request(request)
    @request = request

    mail to: request.requester_mail, subject: 'Solicitud de servicio'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.request_accepted.subject
  #
  def request_accepted(request)
    @request = request

    mail to: request.requester_mail, subject: 'Solicitud de servicio'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.request_denied.subject
  #
  def request_denied(request)
    @request = request
    @deny_reasons = RequestDenyReason.where(request_id: @request.id)

    mail to: request.requester_mail, subject: 'Solicitud de servicio'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.request_completed.subject
  #
  def request_completed(request)
    @request = request

    mail to: request.requester_mail, subject: 'Solicitud de servicio'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.request_mailer.feedback_sent.subject
  #
  def feedback_sent(request)
    @request = request

    mail to: request.requester_mail, subject: 'Solicitud de servicio'
  end
end
