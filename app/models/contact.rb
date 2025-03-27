# frozen_string_literal: true

class Contact < MailForm::Base
  MAIN_MAILER = 'kontakt@shareplate.pl'
  attribute :name, validate: true
  attribute :email,     validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   validate: true
  attribute :subject, validate: true

  def headers
    {
      subject: "Formularz kontaktowy Temat: #{subject}",
      # to: %("#{name}" <#{email}>),
      to: MAIN_MAILER,
      from: MAIN_MAILER
    }
  end
end
