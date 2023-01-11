# Preview all emails at http://localhost:3000/rails/mailers/request_mailer
class RequestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/new_request
  def new_request
    RequestMailer.new_request
  end

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/request_accepted
  def request_accepted
    RequestMailer.request_accepted
  end

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/request_denied
  def request_denied
    RequestMailer.request_denied
  end

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/request_completed
  def request_completed
    RequestMailer.request_completed
  end

  # Preview this email at http://localhost:3000/rails/mailers/request_mailer/feedback_sent
  def feedback_sent
    RequestMailer.feedback_sent
  end

end
