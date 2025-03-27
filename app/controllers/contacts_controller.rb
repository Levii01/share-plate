# frozen_string_literal: true

class ContactsController < ApplicationController
  def new
    @contact ||= Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.request = request
    if @contact.valid? && @contact.deliver
      flash.now[:error] = nil
      redirect_to root_path, notice: 'Wiadomość została wysłana'
    else
      flash.now[:error] = error_email_sent
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end

  def error_email_sent
    "Coś poszło nie tak podczas wysyłania wiadomości.</br>Możesz napisać do nas maila na adres: <b>#{Contact::MAIN_MAILER}</b>"
  end
end
