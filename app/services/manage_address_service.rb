class ManageAddressService
  def initialize(user)
    @user = user
  end

  def call(country_name, zipcode, state_code, city, neighborhood, street, number, complement)
    if @user.address.nil?
      address = Address.new
    else
      address = @user.address
    end

    country = Country.find_by_name(country_name)
    if country_name == 'Brasil'
      state = State.find_by_code(state_code)
      state_name = state.name
    else
      state = nil
      state_name = state_code.presence
    end

    address.country = country
    address.state = state
    address.state_name = state_name
    address.zip_code = zipcode.presence
    address.city = city.presence
    address.street = street.presence
    address.neighborhood = neighborhood.presence
    address.number = number.presence
    address.complement = complement.presence
    @user.address = address
  end
end
