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
        if current_user.person.nil?
            @person = Person.new
        else
            @person = current_user.person
        end

        User.transaction do
            @person.name = params['person-name']
            @person.gender = params['person-gender']
            @person.birth_date = params['person-birthdate']
            @person.cpf = params['person-cpf'].delete('.-')
            @person.rg = params['person-rg']
            current_user.person = @person
        end

        flash[:notice] = 'Perfil atualizado com sucesso'
        redirect_to profile_index_path
    rescue => e
        flash[:error] = e.message
        redirect_to profile_index_path

    end
end
