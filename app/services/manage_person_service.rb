class ManagePersonService

    def initialize
    end

    def call(user, name, gender, birth_date, cpf, rg)
        if user.person.nil?
            @person = Person.new
        else
            @person = user.person
        end

        @person.name = name
        @person.gender = gender
        @person.birth_date = birth_date
        @person.cpf = cpf
        if rg.empty?
            @person.rg = nil
        else
            @person.rg = rg
        end
        user.person = @person
    end
end