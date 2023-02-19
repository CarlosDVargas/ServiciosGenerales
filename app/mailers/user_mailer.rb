class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'user_accounts/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts = {})
    opts[:subject] = "Confirmar cuenta"
    super
  end

  def reset_password_instructions(record, token, opts = {})
    opts[:subject] = "Restablecer contraseña"
    super
  end

  def new_request_admin(request, admin)
    @request = request
    @admin = admin

    mail to: @admin.email, subject: "Nueva solicitud de servicio registrada en el sistema"
  end

  def request_assigned(request, worker)
    @request = request
    @worker = worker

    mail to: @worker.email, subject: "Solicitud de servicio: #{request.identifier}"
  end

  def request_reassigned(request, worker)
    @request = request
    @worker = worker

    mail to: @worker.email, subject: "Solicitud de servicio: #{request.identifier}"
  end

  def request_removed(request, worker)
    @request = request
    @worker = worker

    mail to: @worker.email, subject: "Solicitud de servicio: #{request.identifier}"
  end

  def request_reopened(request, worker, reasons)
    @request = request
    @worker = worker
    @reasons = reasons

    mail to: @worker.email, subject: "Solicitud de servicio: #{request.identifier}"
  end
end
