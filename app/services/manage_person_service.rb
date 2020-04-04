class ManagePersonService

  def initialize
  end

  def call(user, name, gender, birth_date, cpf, rg)
    if user.person.nil?
      @person = Person.new
    else
      @person = user.person
    end

    @person.name = name.presence
    @person.gender = gender.presence
    @person.birth_date = birth_date
    @person.cpf = cpf
    @person.rg = rg.presence
    user.person = @person
  end
end