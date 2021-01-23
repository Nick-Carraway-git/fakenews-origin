class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_email(@contact).deliver
      redirect_to root_path
    else
      redirect_to new_contact_path
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :message, :email)
  end
end
