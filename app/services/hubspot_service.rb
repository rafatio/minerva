class HubspotService
    def initialize

    end

    def create_contact(email)
        # we use the "create_or_update" method because the user may have entered an email that is already in use by us
        # in this case, we will call the hubspot update method, passing no properties whatsoever
        # since the only properties that are updated are the ones that we pass, in reality nothing will happen
        Hubspot::Contact.create_or_update!([{email: email}])
    end

    def update_contact(user, params, secondary_emails, previous_companies, education_informations, intended_relationships)
        previous_companies_formatted = []
        education_informations_formatted = []

        previous_companies.each do |item|
            previous_companies_formatted.push('Empresa: ' + (item[:name] || '') + ' | Cargo: ' + (item[:position] || ''))
        end

        education_informations.each do |item|
            education_level = item.education_level.nil?? '' : item.education_level.name
            conclusion_year = item.conclusion_year.nil?? '' : item.conclusion_year.to_s
            education_informations_formatted.push('Nível: ' + (education_level) + ' | Instituição: ' + (item.institution || '') + ' | Curso: ' + (item.course || '') + ' | Ano de conclusão: ' + (conclusion_year))
        end

        hubspot_properties = {
            email: user.email,
            firstname: params['person-name'].split[0],
            lastname: params['person-name'].split.count > 1 ? params['person-name'].split[-1] : nil,
            full_name: params['person-name'],
            gender: params['person-gender'],
            date_of_birth: params['person-birthdate'],
            cpf: params['person-cpf'].delete('.-'),
            rg: params['person-rg'],

            phone: params['contact-mobile'],
            mobilephone: params['contact-mobile'],
            skype: params['contact-skype'],
            facebook: params['contact-facebook'],
            linkedin: params['contact-linkedin'],
            preferred_contact_type: params['contact-preferred'].downcase,
            secondary_email_addresses: secondary_emails.join("\n"),

            country: params['address-country'],
            zip: params['address-country'] == 'Brasil' ? params['address-cep'] : params['address-zipcode'],
            address: (params['address-street'] || '') + ', ' + (params['address-number'] || '') + ', ' + (params['address-complement'] || ''),
            city: params['address-city'],
            state: params['address-state'],
            neighborhood: params['address-neighborhood'],

            company: params['professional-company'],
            jobtitle: params['professional-position'],
            admission_year: params['professional-admission-year'],
            previous_companies: previous_companies_formatted.join("\n"),

            education: education_informations_formatted.join("\n"),

            wishes_to_associate: intended_relationships[:associate].to_s,
            wishes_to_be_mentor: intended_relationships[:mentoring].to_s,
            wishes_to_be_tutor: intended_relationships[:tutoring].to_s,
            wishes_to_contribue_financially: intended_relationships[:financial].to_s,
            intended_relationships_remarks: intended_relationships[:remarks]

        }

        hubspot_contact = Hubspot::Contact.create_or_update!([hubspot_properties])
    end

    def create_deal(user, amount, recurring, isNewUser)
        if (!isNewUser)
            contact = Hubspot::Contact.find_by_email(user.email)
        else
            contact = Hubspot::Contact.create!(user.email)
        end


        deal_properties = {
            dealname: 'Contribuição online ' + (recurring ? 'recorrente' : 'única') + ' ' + Time.now.strftime('%Y-%m-%d'),
            amount: amount,
            pipeline: 'default',
            dealstage: 'closedwon',
            closedate: Time.now.utc.to_datetime.strftime('%Q') # "%Q" means milliseconds
        }

        deal = Hubspot::Deal.create!(0, [], [contact.vid], deal_properties)
    end

end