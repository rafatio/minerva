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
    @country_list = Country.all
    @address = current_user.address
    @professional_information = current_user.professional_information
    @previous_companies = []
    if !@professional_information.nil?
      @previous_companies = @professional_information.previous_companies
    end
    @education_informations = current_user.education_informations
    @intended_relationship = current_user.intended_relationship

    @countries = Country.all
    @education_levels = EducationLevel.all.order(:name)
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
      education_informations = []

      params.each do |item|
        if item[0].starts_with?('contact-secondary-mail')
          secondary_emails.push(item[1])
        elsif item[0].starts_with?('professional-previous-company-name')
          number = item[0][-1]
          company_name = params['professional-previous-company-name' + number]
          company_position = params['professional-previous-company-position' + number]
          previous_companies.push(name: company_name, position: company_position)
        elsif item[0].starts_with?('education-level')
          number = item[0][15..-1] # gets the substring from position 15 to the end of the string
          # position 15 because the string 'education-level' has 15 characters
          education_level = EducationLevel.find_by_name(params['education-level' + number].presence)
          education_information = EducationInformation.new(
            education_level: education_level,
            institution: params['education-institution' + number].presence,
            course: params['education-course' + number].presence,
            conclusion_year: params['education-conclusion-year' + number].presence,
          )
          education_informations.push(education_information)
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
        params['address-country'].gsub('_',' '),
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
      ManageEducationInformationService.new(current_user).call(education_informations)

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

      ###### HUBSPOT INTEGRATION
      intended_relationships = {associate: associate, financial: financial, mentoring: mentoring, tutoring: tutoring, remarks: params['relationship-remarks']}
      HubspotService.new.update_contact(current_user, params, secondary_emails, previous_companies, education_informations, intended_relationships)
    end

    flash[:notice] = 'Perfil atualizado com sucesso'
    redirect_to profile_index_path
  rescue Hubspot::RequestError => e
    Rails.logger.error e.message
    flash[:error] = 'Erro inesperado. Entre em contato com o suporte'
    redirect_to profile_index_path
  rescue Exception => e
    flash[:error] = e.message
    redirect_to profile_index_path
  end
end
