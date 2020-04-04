class ContactsService

  def initialize(user)
    @user = user
  end

  def get_contacts(contact_type_name)
    contact = @user.contacts.joins(:contact_type).where(contact_types: {name: contact_type_name})
    return contact
  end

  def manage_unique_contact(contact_type_name, contact_value, preferred_contact_type)
    contact = get_contacts(contact_type_name).first
    preferred = preferred_contact_type.casecmp?(contact_type_name)
    if contact.nil?
      if !contact_value.empty?
        contact_type = ContactType.find_by_name(contact_type_name)
        contact = @user.contacts.new(contact_type: contact_type, value: contact_value, preferred: preferred)
        contact.save
      end
    else
      if !contact_value.empty?
        contact.value = contact_value
        contact.preferred = preferred
        contact.save
      else
        contact.delete
      end
    end
  end


  def manage_multiple_contact(contact_type_name, contact_values)
    #simply delete the old ones and insert the new ones
    contacts = get_contacts(contact_type_name)
    contacts.destroy_all

    if !contact_values.empty?
      contact_type = ContactType.find_by_name(contact_type_name)
      contact_values.each do |value|
        contact = @user.contacts.new(contact_type: contact_type, value: value)
        contact.save
      end
    end
  end
end
