class ProfileController < ApplicationController

    before_action :authenticate_user!
    def index
        @person = current_user.person
        @mobile_contact = current_user.contacts.joins(:contact_type).where(contact_types: {name: 'Celular'}).first
        @facebook_contact = current_user.contacts.joins(:contact_type).where(contact_types: {name: 'Facebook'}).first
        @linkedin_contact = current_user.contacts.joins(:contact_type).where(contact_types: {name: 'Linkedin'}).first
        @skype_contact = current_user.contacts.joins(:contact_type).where(contact_types: {name: 'Skype'}).first
        @secondary_mail_contacts = current_user.contacts.joins(:contact_type).where(contact_types: {name: 'Email secundário'})
        @address = current_user.address
        @professional_information = current_user.professional_information
        @education_information = current_user.education_information
        @intended_relationship = current_user.intended_relationship

        @countries = Country.all
    end

    def create
        User.transaction do

            ###### PERSON
            ManagePersonService.new.call(current_user, params['person-name'], params['person-gender'], params['person-birthdate'], params['person-cpf'].delete('.-'), params['person-rg'])

            ###### CONTACT
            contacts_service = ManageContactsService.new(current_user)
            contacts_service.manage_unique_contact('Celular', params['contact-mobile'])
            contacts_service.manage_unique_contact('Facebook', params['contact-facebook'])
            contacts_service.manage_unique_contact('Linkedin', params['contact-linkedin'])
            contacts_service.manage_unique_contact('Skype', params['contact-skype'])

            secondary_emails = Array.new
            params.each do |item|
                if item[0].starts_with?("contact-secondary-mail")
                    secondary_emails.push(item[1])
                end
            end
            contacts_service.manage_multiple_contact('Email secundário', secondary_emails)

        end

        flash[:notice] = 'Perfil atualizado com sucesso'
        redirect_to profile_index_path
    rescue => e
        flash[:error] = e.message
        redirect_to profile_index_path

    end
end
