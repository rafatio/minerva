class ProfileController < ApplicationController

    before_action :authenticate_user!
    def index
        @person = current_user.person
        contacts_service = ContactsService.new(current_user)
        @mobile_contact = contacts_service.get_contacts('Celular').first
        @facebook_contact = contacts_service.get_contacts('Facebook').first
        @linkedin_contact = contacts_service.get_contacts('Linkedin').first
        @skype_contact = contacts_service.get_contacts('Skype').first
        @secondary_mail_contacts = contacts_service.get_contacts('Email secundário')
        @country_list = Country.all.order(:name)
        @address = current_user.address
        @professional_information = current_user.professional_information
        @previous_companies = []
        if !@professional_information.nil?
            @previous_companies = @professional_information.previous_companies
        end
        @education_information = current_user.education_information
        @intended_relationship = current_user.intended_relationship

        @countries = Country.all
    end

    def create
        User.transaction do

            ###### PERSON
            ManagePersonService.new.call(
                current_user,
                params['person-name'],
                params['person-gender'],
                params['person-birthdate'],
                params['person-cpf'].delete('.-'),
                params['person-rg'])

            ###### CONTACT
            contacts_service = ContactsService.new(current_user)
            contacts_service.manage_unique_contact('Celular', params['contact-mobile'], params['contact-preferred'])
            contacts_service.manage_unique_contact('Facebook', params['contact-facebook'], params['contact-preferred'])
            contacts_service.manage_unique_contact('Linkedin', params['contact-linkedin'], params['contact-preferred'])
            contacts_service.manage_unique_contact('Skype', params['contact-skype'], params['contact-preferred'])

            secondary_emails = []
            previous_companies = []

            params.each do |item|
                if item[0].starts_with?('contact-secondary-mail')
                    secondary_emails.push(item[1])
                elsif item[0].starts_with?('professional-previous-company')
                    previous_companies.push(item[1])
                end
            end
            contacts_service.manage_multiple_contact('Email secundário', secondary_emails)

            ###### ADDRESS
            if params['address-country'] == 'Brasil'
                zipcode = params['address-cep']
            else
                zipcode = params['address-zipcode']
            end
            ManageAddressService.new(current_user).call(
                params['address-country'],
                zipcode.delete('.-'),
                params['address-state'],
                params['address-city'],
                params['address-neighborhood'],
                params['address-street'],
                params['address-number'],
                params['address-complement'])

            ###### PROFESSIONAL INFORMATION
            ManageProfessionalInformationService.new(current_user).call(
                params['professional-company'],
                params['professional-position'],
                params['professional-admission-year'],
                previous_companies)

            ###### EDUCATION INFORMATION
            ManageEducationInformationService.new(current_user).call(
                params['education-graduation-institution'],
                params['education-graduation-course'],
                params['education-graduation-year'])

            ###### INTENDED RELATIONSHIP
            associate = !params['relationship-associate'].nil?
            financial = !params['relationship-financial'].nil?
            mentoring = !params['relationship-mentoring'].nil?
            tutoring = !params['relationship-tutoring'].nil?
            ManageIntendedRelationshipService.new(current_user).call(
                associate,
                financial,
                mentoring,
                tutoring,
                params['relationship-remarks'])

        end

        flash[:notice] = 'Perfil atualizado com sucesso'
        redirect_to profile_index_path
    rescue => e
        flash[:error] = e.message
        redirect_to profile_index_path

    end
end
